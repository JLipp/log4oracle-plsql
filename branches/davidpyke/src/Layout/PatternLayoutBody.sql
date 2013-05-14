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
type body PatternLayout as
	
	overriding member procedure ActivateOptions is
	begin
		self.m_converters := PatternParser.Parse(self.ConversionPattern);
	end;
	
	overriding member function Format(event LoggingEvent) return varchar2 is
		l_converters PatternConverterArray := self.m_converters;
		l_index number;
		l_message varchar2(32767);
	begin
		if event is null then
			raise LogUtil.ArgumentNullException;
		end if;
		
		l_index := l_converters.FIRST;
		while l_index is not null loop
			l_message := l_message||l_converters(l_index).Format(event);
			l_index := l_converters.NEXT(l_index);
		end loop;
		
		return l_message;
	end;
	
	constructor function PatternLayout return self as result is
	begin
		self.IgnoresException := 1;
		return;
	end;
	
end;
/
