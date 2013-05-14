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
type body PatternConverter as
	
	constructor function PatternConverter(key varchar2, value varchar2) return self as result is
	begin
		self.Key := key;
		self.Value := value;
		self.m_min := 0;
		self.m_max := 471234567;
		self.m_leftAlign := 0;
		return;
	end;
	
	static function Convert(event LoggingEvent, value varchar2) return varchar2 is
		l_ret varchar2(32767);
	begin
		execute immediate '
			declare
				event LoggingEvent := :a;
			begin
				:b := '||value||';
			end;'
			using event, out l_ret;
		
		return l_ret;
	end;
	
	member function Format(event LoggingEvent) return varchar2 is
		msg varchar2(32767);
		len number;
	begin
		msg := PatternConverter.Convert(event, self.Value);
		if not (m_min < 0 and m_max >= 471234567) then
			len := length(msg);
			if len > m_max then
				msg := substr(len - m_max, m_max);
				len := m_max;
			end if;
			if len < m_min then
				if m_leftAlign != 0 then
					msg := rpad(msg, m_min, ' ');
				else
					msg := lpad(msg, m_min, ' ');
				end if;
			end if;
		end if;
		
		return msg;
	exception
		when others then
			return 'error!@'||self.Value;
	end;
	
end;
/
