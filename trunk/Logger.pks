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
type Logger as object
( 
  /* name of the logger */
  name varchar2(255),
  
  /* Test if a level is enabled for logging */
  member function IsDebugEnabled return boolean,
  member function IsInfoEnabled return boolean,
  member function IsWarnEnabled return boolean,
  member function IsErrorEnabled return boolean,
  member function IsFatalEnabled return boolean,
  
  /* Log a message */
  member procedure Debug(message varchar2),
  member procedure Info(message varchar2),
  member procedure Error(message varchar2),
  member procedure Warn(message varchar2),
  member procedure Fatal(message varchar2),

  /* Log a message and exception */
  member procedure Debug(message varchar2, error varchar2),
  member procedure Info(message varchar2, error varchar2),
  member procedure Warn(message varchar2, error varchar2),
  member procedure Error(message varchar2, error varchar2),
  member procedure Fatal(message varchar2, error varchar2)

  );
/
