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
type body LayoutSkeleton as
	
	not final member procedure ActivateOptions is
	begin
		null;
	end;
	
	not final member function Format(event LoggingEvent) return varchar2 is
	begin
		null;
	end;
	
	member function GetContentType return string is
	begin
		return 'text/plain';
	end;
	
	constructor function LayoutSkeleton return self as result is
	begin
		self.IgnoresException := 1;
		return;
	end;
	
end;
/
