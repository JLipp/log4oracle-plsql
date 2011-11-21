/** 
* Copyright 2011 Juergen Lipp
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
* 
*     http://www.apache.org/licenses/LICENSE-2.0
* 
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

create or replace 
package body PatternParser as
	
	m_globalRulesRegistry PatternConverterArray;
	m_converters PatternConverterArray;
	
	procedure ProcessConverter(converterName varchar2, options varchar2, leftAlign boolean, minLength number, maxLength number) is
	  i number;
	  align number;
	begin
		if leftAlign then
			align := 1;
		else
			align := 0;
		end if;
	
		LogLog.Debug('Converter ['||converterName||'] Option ['||options||'] Format [min='||minLength||',max='||maxLength||',leftAlign='||align||']');
		
		m_converters.EXTEND(1);
		i := m_converters.LAST;
		m_converters(i) := new PatternConverter(converterName, options);
		
		m_converters(i).m_min := minLength;
		m_converters(i).m_max := maxLength;
		m_converters(i).m_leftAlign := align;
	end;
	
	procedure ProcessLiteral(text varchar2) is
	begin
		if length(text) > 0 then
			ProcessConverter('literal', ''''||text||'''', false, 0, 2147483647);
		end if;
	end;
	
	function ParseInternal(pattern varchar2, matches PatternConverterArray) return PatternConverterArray is
		offset number := 1;
		i number;
		remainingStringLength number;
		LeftAlign boolean;
		MinTextWidth number := 0;
		MaxTextWidth number := 2147483647;
	begin
		-- Initialize new pattern
		m_converters := new PatternConverterArray();
		
		while offset < length(pattern) loop
			i := instr(pattern, '%', offset);
			if (i < 1 or i = length(pattern)) then
				ProcessLiteral(substr(pattern, offset));
				offset := length(pattern);
			else
				if substr(pattern, i+1, 1) = '%' then
					-- Escaped
					ProcessLiteral(substr(pattern, offset, i - offset + 1));
					offset := i + 2;
				else
					ProcessLiteral(substr(pattern, offset, i - offset));
					offset := i + 1;
					
					LeftAlign := false;
					MinTextWidth := 0;
					MaxTextwidth := 2147483647;
					-- Process formatting options

					-- Look for the align flag
					if offset <= length(pattern) then
						if substr(pattern, offset, 1) = '-' then
							LeftAlign := true;
							offset := offset + 1;
						end if;
					end if;
					
					-- Look for the minimum length
					while (offset <= length(pattern) and 
					       translate(substr(pattern, offset, 1), 'a1234567890', 'a') is null) loop
						-- Seen digit
						if MinTextWidth < 0 then
							MinTextWidth := 0;
						end if;
						MinTextWidth := (MinTextWidth * 10) + to_number(substr(pattern, offset, 1));
						offset := offset + 1;
					end loop;
					
					-- Look for the separator between min and max
					if offset <= length(pattern) then
						if substr(pattern, offset, 1) = '.' then
							offset := offset + 1;
						end if;
					end if;
					
					-- Look for the maximum length
					while (offset <= length(pattern) and 
					       translate(substr(pattern, offset, 1), 'a1234567890', 'a') is null) loop
						-- Seen digit
						if MaxTextWidth >= 2147483647 then
							MaxTextWidth := 0;
						end if;
						MaxTextWidth := (MaxTextWidth * 10) + to_number(substr(pattern, offset, 1));
						offset := offset + 1;
					end loop;

					remainingStringLength := length(pattern) - (offset - 1);
					
					-- Look for pattern
					for m in matches.FIRST..matches.LAST loop
						if length(matches(m).Key) <= remainingStringLength then
							if substr(pattern, offset, length(matches(m).Key)) = matches(m).Key then
								-- Found match
								offset := offset + length(matches(m).Key);
								
								-- Look for option
								/** TODO */
								
								ProcessConverter(matches(m).Key, matches(m).Value, LeftAlign, MinTextWidth, MaxTextWidth);
								exit;
								
							end if;
						end if;
					end loop;
				end if;
			end if;
		end loop;
		
		-- Remove ending newline pattern due to usage of PUT_LINE
		if m_converters(m_converters.LAST).Key in ('n', 'newline') then
			m_converters.DELETE(m_converters.LAST);
		end if;
		
		return m_converters;
	end;
	
	function GlobalRulesRegistry return PatternConverterArray is
	begin
		return m_globalRulesRegistry;
	end;
	
	function Parse(pattern varchar2) return PatternConverterArray is
		converterNamesCache PatternConverterArray;
	begin
		converterNamesCache := PatternParser.GlobalRulesRegistry;
		return ParseInternal(pattern, converterNamesCache);
	end;
	
begin
	m_globalRulesRegistry := new PatternConverterArray(
		new PatternConverter('literal',  null),
		new PatternConverter('newline',  'chr(13)||chr(10)'),
		new PatternConverter('n',        'chr(13)||chr(10)'),
		
		new PatternConverter('C',        'event.LoggerName'),
		new PatternConverter('logger',   'event.LoggerName'),
		
		new PatternConverter('d',        'to_char(event.DateTime, ''yyyy-mm-dd hh24:mi:ss,ff3'')'),
		new PatternConverter('date',     'to_char(event.DateTime, ''yyyy-mm-dd hh24:mi:ss,ff3'')'),
		
		new PatternConverter('exception', 'event.ExceptionString'),
		
		new PatternConverter('m',         'event.Message'),
		new PatternConverter('message',   'event.Message'),
		
		new PatternConverter('p',         'event.LLevel.DisplayName'),
		new PatternConverter('level',     'event.LLevel.DisplayName'),
		
		new PatternConverter('utcdate',   'to_char(event.DateTime at time zone ''+00:00'', ''yyyy-mm-dd hh24:mi:ss,ff3'')'),
		new PatternConverter('utcDate',   'to_char(event.DateTime at time zone ''+00:00'', ''yyyy-mm-dd hh24:mi:ss,ff3'')'),
		new PatternConverter('UtcDate',   'to_char(event.DateTime at time zone ''+00:00'', ''yyyy-mm-dd hh24:mi:ss,ff3'')'),
		
		new PatternConverter('w',         'event.UserName'),
		new PatternConverter('username',  'event.UserName'));
end PatternParser;
/
