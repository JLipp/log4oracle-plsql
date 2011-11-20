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
type body AppenderSkeleton as
	
	member function RenderLoggingEvent(loggingEvent LoggingEvent) return varchar2 as
		writer varchar2(32767);
	begin
		writer := self.Layout.Format(loggingEvent);
		if loggingEvent.ExceptionString is not null and
		   self.Layout.IgnoresException >= 1 then
			writer := writer||chr(13)||chr(10)||loggingEvent.ExceptionString;
		end if;
		return writer;
	end;
	
	member procedure DoAppend(loggingEvent LoggingEvent) as
	begin
		if (loggingEvent.LLevel >= Treshold) then
			Append(loggingEvent);
		end if;
	end;
	
	not final member procedure Append(loggingEvent LoggingEvent) as
	begin
		null;
	end;
	
end;
/
