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
type body GenericException as
	
	constructor function GenericException(message varchar2 default null) return self as result as
	begin
		self.ErrorStack := dbms_utility.format_error_stack;
		self.ErrorBacktrace := dbms_utility.format_error_backtrace;
		self.CallStack := dbms_utility.format_call_stack;
		self.Message := message;

		return;
	end;
	
	member function Format return varchar2 is
	begin
		if self.Message is null then
			return self.ErrorBacktrace||self.ErrorStack||self.CallStack;
		else
			return self.Message||LogUtil.CRLF||self.ErrorBacktrace||self.ErrorStack||self.CallStack;
		end if;
	end;
	
end;
/
