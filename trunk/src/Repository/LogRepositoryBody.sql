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
package body LogRepository as

  parent_logger LoggerImpl;
  
  function Exists(name varchar2) return Logger is
  begin
  	null;
  end;
  
  /*
  function GetCurrentLoggers return LoggerArray is
  begin
    raise NotImplementedException; 
  end;
  */  
  
  function GetLogger(name varchar2) return Logger is
  begin
    if parent_logger is null then
      parent_logger := LoggerImpl(0, LogLevel.Debug, 'root', null, AppenderArray());
    end if;
	  return LoggerImpl(1, null, name, anydata.ConvertObject(parent_logger), AppenderArray());
  end;
  
  function GetRepository(name varchar2) return binary_integer is
  begin
    return 1;
  end;

  procedure ResetConfiguration is
  begin
    null;
  end;
  
  procedure Shutdown is
  begin
    null;
  end;

end LogRepository;
/
