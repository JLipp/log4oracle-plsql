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
type body Logger as

  /* This is the most generic printing method that is intended to be used by wrappers. */
  member procedure Log(logEvent LoggingEvent) as
    x number;
    c Logger;
    writes number := 0;
  begin

    if logEvent is null then
      --raise LogUtil.ArgumentNullException;
      null;
    end if;

    c := self;
    while c is not null loop
      if IsEnabledFor(logEvent.LLevel) then

        for i in c.m_appenders.first..c.m_appenders.last loop
          if c.m_appenders.exists(i) then
            c.m_appenders(i).DoAppend(logEvent);
          end if;
        end loop;

      end if;      
      writes := writes + c.m_appenders.count;
      
      if not c.GetAdditivity then
        exit;
      end if;
      
      x := c.m_parent.GetObject(c);
    end loop;
    
    if writes = 0 then
      dbms_output.put_line('No appenders could be found for logger ['||m_name||']');
      dbms_output.put_line('Please initialize the log4oracle-plsql system properly.');
      /* TODO: LogUtil.LogLog.Debug ... instead of dbms_output */
    end if;

  exception
    when others then
      --LogUtil.LogLog.Error(sqlerrm(sqlcode));
      null;
  end;

  member procedure AddAppender(appender LogAppender) as
  begin
    null;
  end;
  
  member function GetAllAppenders return LogAppender as
  begin
    null;
  end;
  
  member function GetAppender return LogAppender as
  begin
    null;
  end;
  
  member procedure RemoveAllAppenders as
  begin
    null;
  end;
  
  member procedure RemoveAppender(name varchar2) as
  begin
    null;
  end;
  
  member procedure RemoveAppender(appender LogAppender) as
  begin
    null;
  end;
  
  member function GetAdditivity return boolean as
  begin
    if m_additive = 1 then
      return true;
    end if;
    
    return false;
  end;
  
  member procedure SetAdditivity(value boolean) as
  begin
    null;
  end;
  
  member function GetEffectiveLevel return LogLevel as
    x number;
    c Logger;
  begin
    c := self;
    while c is not null loop
      if c.m_level is not null then
        return c.m_level;
      end if;
      x := c.m_parent.GetObject(c);
    end loop;

    return null;
  end;
  
  member function GetLevel return LogLevel as
  begin
    null;
  end;
  
  member procedure SetLevel(logLevel LogLevel) as
  begin
    null;
  end;
  
  member function GetLoggerRepository return varchar2 as
  begin
    null;
  end;
  
  member function GetName return varchar2 as
  begin
    null;
  end;
  
  member function GetParent return Logger as
  begin
    null;
  end;
  
  member function IsEnabledFor(logLevel LogLevel) return boolean as
  begin
    if logLevel is not null then
      return logLevel >= GetEffectiveLevel;
    end if;
    
    return false;
  end;
  
end;
/
