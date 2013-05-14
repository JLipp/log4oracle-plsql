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
type LoggingEvent 
as object
(
	ExceptionObject GenericException, -- The object representation of the exception
	LLevel LogLevel, -- Level of logging event.
	LoggerName varchar2(255), -- The logger name.
	Message varchar2(2000), -- The application supplied message.
	DateTime timestamp with time zone, -- The time the event was logged
	UserName varchar2(255), -- String representation of the user

	--LocationInfo	 Location information for the caller.
    Location LocationInfo, --where event was created
	
	constructor function LoggingEvent(loggerName varchar2, logLevel LogLevel, message varchar2, error GenericException, loc LocationInfo) return self as result
	--Domain	 String representation of the AppDomain.
	--Identity	 String representation of the identity.
	--Properties	 Additional event specific properties
	--ThreadName	 The name of thread
);
/
