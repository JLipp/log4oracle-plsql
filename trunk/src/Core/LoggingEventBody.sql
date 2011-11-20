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
type body LoggingEvent as
	
	constructor function LoggingEvent(loggerName varchar2, logLevel LogLevel, message varchar2, showError boolean) return self as result as
	begin
		self.LoggerName := loggerName;
		self.LLevel := logLevel;
		self.DateTime := CURRENT_TIMESTAMP;
		self.UserName := user;
		self.Message := message;
		if showError then
			self.ExceptionString := dbms_utility.format_error_stack||dbms_utility.format_error_backtrace;
		end if;
		
		return;
	end;
	
end;
/
