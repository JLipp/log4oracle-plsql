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

	procedure ProcessConverter(converterName varchar2, converterValue varchar2, options varchar2, leftAlign boolean, minLength number, maxLength number) is
	  i number;
	  align number;
	begin
		if leftAlign then
			align := 1;
		else
			align := 0;
		end if;

		LogLog.Debug('Converter ['||converterName||'] Value ['||converterValue||'] Option ['||options||'] Format [min='||minLength||',max='||maxLength||',leftAlign='||align||']');

		m_converters.EXTEND(1);
		i := m_converters.LAST;
		m_converters(i) := new PatternConverter(converterName, converterValue );

		m_converters(i).m_min := minLength;
		m_converters(i).m_max := maxLength;
		m_converters(i).m_leftAlign := align;
		m_converters(i).m_options := options;
	end;

	procedure ProcessLiteral(text varchar2) is
	begin
		if length(text) > 0 then
			ProcessConverter('literal', ''''||text||'''', null,  false, 0, 2147483647);
		end if;
	end;

	function ParseInternal(pattern varchar2, matches PatternConverterArray) return PatternConverterArray is
		offset number := 1;
		optoffset number := 0;
    options varchar2(4000) := NULL;
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

--LogLog.Debug('Look for the align flag:'||substr(pattern, offset, 1));

					-- Look for the align flag
					if offset <= length(pattern) then
						if substr(pattern, offset, 1) = '-' then
							LeftAlign := true;
							offset := offset + 1;
						end if;
					end if;

--LogLog.Debug('Look for min length:'||substr(pattern, offset, 1));
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

--LogLog.Debug('Look for length seperator:'||substr(pattern, offset, 1));
					-- Look for the separator between min and max
					if offset <= length(pattern) then
						if substr(pattern, offset, 1) = '.' then
							offset := offset + 1;
						end if;
					end if;

--LogLog.Debug('Look for max length:'||substr(pattern, offset, 1));
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
--LogLog.Debug('Look for options:'||substr(pattern, offset, 1));
                options := null;
          			if offset <= length(pattern) then
      						if substr(pattern, offset, 1) = '{' then
                    optoffset := offset;
          					while (offset <= length(pattern) and substr(pattern, offset, 1) != '}' ) loop
          						offset := offset + 1;
          					end loop;
        						offset := offset + 1;
                    options := substr(pattern, optoffset, offset-optoffset);
      						end if;
      					end if;

								ProcessConverter(matches(m).Key, matches(m).Value, options, LeftAlign, MinTextWidth, MaxTextWidth);
								exit;

							end if;
						end if;
					end loop;
          --TODO check if pattern found
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
/*
    "Log::Log4perl::Layout::PatternLayout"
        on the other hand is very powerful and allows for a very flexible
        format in "printf"-style. The format string can contain a number of
        placeholders which will be replaced by the logging engine when it's
        time to log the message:

            %c Category of the logging event.
            %C Fully qualified package (or class) name of the caller
            %d Current date in yyyy/MM/dd hh:mm:ss format
            %F File where the logging event occurred
            %H Hostname (if Sys::Hostname is available)
            %l Fully qualified name of the calling method followed by the
               callers source the file name and line number between
               parentheses.
            %L Line number within the file where the log statement was issued
            %m The message to be logged
            %m{chomp} The message to be logged, stripped off a trailing newline
            %M Method or function where the logging request was issued
            %n Newline (OS-independent)
            %p Priority of the logging event
            %P pid of the current process
            %r Number of milliseconds elapsed from program start to logging
               event
            %R Number of milliseconds elapsed from last logging event to
               current logging event
            %T A stack trace of functions called
            %x The topmost NDC (see below)
            %X{key} The entry 'key' of the MDC (see below)
            %% A literal percent (%) sign

        NDC and MDC are explained in "Nested Diagnostic Context (NDC)" and
        "Mapped Diagnostic Context (MDC)".

        Also, %d can be fine-tuned to display only certain characteristics
        of a date, according to the SimpleDateFormat in the Java World
        (http://java.sun.com/j2se/1.3/docs/api/java/text/SimpleDateFormat.ht
        ml)

        In this way, %d{HH:mm} displays only hours and minutes of the
        current date, while %d{yy, EEEE} displays a two-digit year, followed
        by a spelled-out (like "Wednesday").
*/

begin
	m_globalRulesRegistry := new PatternConverterArray(
		new PatternConverter('literal',  null),
		new PatternConverter('newline',  'chr(13)||chr(10)'),
		new PatternConverter('n',        'chr(13)||chr(10)'),

		new PatternConverter('c',        q'[event.Location.owner||'.'||event.Location.name]'),
		new PatternConverter('C',        'event.LoggerName'),
		new PatternConverter('logger',   'event.LoggerName'),

		new PatternConverter('d',        q'[to_char(event.DateTime, case NVL(options,'NULL') 
                            when '{ISO8601}' then 'yyyy-MM-dd HH24:mi:ss,ff3'
                            when '{DATE}' then 'dd MON yyyy HH24:mi:ss,ff3'
                            when 'NULL' then 'yyyy-mm-dd hh24:mi:ss,ff3' 
                            else options end)]'),

--		new PatternConverter('date',     'to_char(event.DateTime, ''yyyy-mm-dd hh24:mi:ss,ff3'')'),

		new PatternConverter('exception', 'event.ExceptionString.Format()'),

		new PatternConverter('L',         'event.Location.lineno'),
		new PatternConverter('M',        'event.Location.name'),


		new PatternConverter('m',         'event.Message'),
		new PatternConverter('message',   'event.Message'),

		new PatternConverter('p',         'event.LLevel.DisplayName'),
		new PatternConverter('level',     'event.LLevel.DisplayName'),

		new PatternConverter('utcdate',   q'[to_char(event.DateTime at time zone '+00:00', 'yyyy-mm-dd hh24:mi:ss,ff3')]'),
		new PatternConverter('utcDate',   q'[to_char(event.DateTime at time zone '+00:00', 'yyyy-mm-dd hh24:mi:ss,ff3')]'),
		new PatternConverter('UtcDate',   q'[to_char(event.DateTime at time zone '+00:00', 'yyyy-mm-dd hh24:mi:ss,ff3')]'),

		new PatternConverter('w',         'event.UserName'),
		new PatternConverter('username',  'event.UserName')

    --unimplemented
--		new PatternConverter('r',         'NULL'),
--		new PatternConverter('R',         'NULL'),
--		new PatternConverter('T',         'NULL')
    );

end PatternParser;
/

