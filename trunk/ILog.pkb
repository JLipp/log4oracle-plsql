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
type body ILog as

  member function IsDebugEnabled return boolean as
  begin
    return m_logger.IsEnabledFor(LogLevel.Debug);
  end;
  
  member function IsErrorEnabled return boolean as
  begin
    return m_logger.IsEnabledFor(LogLevel.Error);
  end;
  
  member function IsFatalEnabled return boolean as
  begin
    return m_logger.IsEnabledFor(LogLevel.Fatal);
  end;
  
  member function IsInfoEnabled return boolean as
  begin
    return m_logger.IsEnabledFor(LogLevel.Info);
  end;
  
  member function IsWarnEnabled return boolean as
  begin
    return m_logger.IsEnabledFor(LogLevel.Warn);
  end;
  
  member procedure Debug(message varchar2) as
  begin
    m_logger.Log(LoggingEvent(m_logger.m_name, LogLevel.Debug, message, null));
  end;
  
  member procedure Debug(message varchar2, error varchar2) as
  begin
    m_logger.Log(LoggingEvent(m_logger.m_name, LogLevel.Debug, message, error));
  end;
  
  member procedure Error(message varchar2) as
  begin
    m_logger.Log(LoggingEvent(m_logger.m_name, LogLevel.Error, message, null));
  end;
  
  member procedure Error(message varchar2, error varchar2) as
  begin
    m_logger.Log(LoggingEvent(m_logger.m_name, LogLevel.Error, message, error));
  end;
  
  member procedure Fatal(message varchar2) as
  begin
    m_logger.Log(LoggingEvent(m_logger.m_name, LogLevel.Fatal, message, null));
  end;
  
  member procedure Fatal(message varchar2, error varchar2) as
  begin
    m_logger.Log(LoggingEvent(m_logger.m_name, LogLevel.Fatal, message, error));
  end;
  
  member procedure Info(message varchar2) as
  begin
    m_logger.Log(LoggingEvent(m_logger.m_name, LogLevel.Info, message, null));
  end;
  
  member procedure Info(message varchar2, error varchar2) as
  begin
    m_logger.Log(LoggingEvent(m_logger.m_name, LogLevel.Info, message, error));
  end;
  
  member procedure Warn(message varchar2) as
  begin
    m_logger.Log(LoggingEvent(m_logger.m_name, LogLevel.Warn, message, null));
  end;
  
  member procedure Warn(message varchar2, error varchar2) as
  begin
    m_logger.Log(LoggingEvent(m_logger.m_name, LogLevel.Warn, message, error));
  end;
  
end;
/
