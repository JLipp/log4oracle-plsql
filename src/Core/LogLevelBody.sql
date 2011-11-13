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
type body LogLevel as

  constructor function LogLevel(logLevel binary_integer) return self as result as
  begin
    self.Name := case logLevel
                   when 0 then 'ALL'
                   when 30000 then 'DEBUG'
                   when 40000 then 'INFO'
                   when 60000 then 'WARN'
                   when 70000 then 'ERROR'
                   when 110000 then 'FATAL'
                   when 999999 then 'OFF'
                 end;
    
    -- only known log levels are allowed, others are null
    if not self.Name is null then
      self.Value := logLevel;
    end if;
    
    return;
  end;
  
  /* Returns log level value as an indication of relative values to be sortable. */
  map member function Compare return binary_integer as
  begin
    return Value;
  end;

  static function AllLevels return LogLevel as
  begin
    return LogLevel(0);
  end;
  
  static function Debug return LogLevel as
  begin
    return LogLevel(30000);
  end;
  
  static function Info return LogLevel as
  begin
    return LogLevel(40000);
  end;
  
  static function Warn return LogLevel as
  begin
    return LogLevel(60000);
  end;
  
  static function Error return LogLevel as
  begin
    return LogLevel(70000);
  end;
  
  static function Fatal return LogLevel as
  begin
    return LogLevel(110000);
  end;
  
  static function Off return LogLevel as
  begin
    return LogLevel(999999);
  end;
end;
/
