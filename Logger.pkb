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
type body Logger as

  member function IsEnabledFor(logLevel binary_integer) return boolean as
  begin
    return true;
  end;
  
  member function IsDebugEnabled return boolean as
  begin
    return false;
  end;
  
  member function IsErrorEnabled return boolean as
  begin
    return false;
  end;
  
  member function IsFatalEnabled return boolean as
  begin
    return false;
  end;
  
  member function IsInfoEnabled return boolean as
  begin
    return false;
  end;
  
  member function IsWarnEnabled return boolean as
  begin
    return false;  
  end;
  
  member procedure Debug(message varchar2) as
  begin
    dbms_output.put_line(message);
  end;
  
  member procedure Debug(message varchar2, error varchar2) as
  begin
    null;
  end;
  
  member procedure Error(message varchar2) as
  begin
    null;
  end;
  
  member procedure Error(message varchar2, error varchar2) as
  begin
    null;
  end;
  
  member procedure Fatal(message varchar2) as
  begin
    null;
  end;
  
  member procedure Fatal(message varchar2, error varchar2) as
  begin
    null;
  end;
  
  member procedure Info(message varchar2) as
  begin
    null;
  end;
  
  member procedure Info(message varchar2, error varchar2) as
  begin
    null;
  end;
  
  member procedure Warn(message varchar2) as
  begin
    null;
  end;
  
  member procedure Warn(message varchar2, error varchar2) as
  begin
    null;
  end;
end;
/
