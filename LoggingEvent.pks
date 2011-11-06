--
-- Copyright 2011 J�rgen Lipp
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
  ExceptionString varchar2(2000), -- The string representation of the exception
  LLevel number, -- Level of logging event.
  LoggerName varchar2(255), -- The logger name.
  Message varchar2(4000), -- The application supplied message.
  DateTime timestamp(3), -- The time the event was logged
  UserName varchar2(255), -- String representation of the user

  constructor function LoggingEvent(logger Logger, logLevel LogLevel, message varchar2, exceptionString varchar2) return self as result
  --Domain	 String representation of the AppDomain.
  --Identity	 String representation of the identity.
  --LocationInfo	 Location information for the caller.
  --Properties	 Additional event specific properties
  --ThreadName	 The name of thread
);
/
