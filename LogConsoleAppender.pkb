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
type body LogConsoleAppender as

  constructor function LogConsoleAppender return self as result as
  begin
    dbms_output.enable(buffer_size => NULL);
  end;
  
  overriding member procedure Append(loggingEvent LoggingEvent) as
  begin
    dbms_output.put_line(LogLevel(loggingEvent.LLevel).Name||' - '||loggingEvent.Message );
  end;
  
end;
/
