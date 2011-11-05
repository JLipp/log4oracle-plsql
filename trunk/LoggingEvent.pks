--
-- Copyright 2011 Jürgen Lipp
-- 
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--     http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
create or replace 
type LoggingEvent as object
(
	Error varchar2(2000);
	LogLevel 

);
/


Domain	 String representation of the AppDomain.
ExceptionString	 The string representation of the exception
Identity	 String representation of the identity.
LogLevel	 Level of logging event.
--LocationInfo	 Location information for the caller.
LoggerName	 The logger name.
Message	 The application supplied message.
--Properties	 Additional event specific properties
ThreadName	 The name of thread
TimeStamp	 The time the event was logged
UserName	 String representation of the user