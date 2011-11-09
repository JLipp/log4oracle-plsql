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
  /* Private fields */
  m_additive integer,
  m_level LogLevel,
  m_name varchar2(255),
  m_parent anydata,
  m_appenders LogAppenderArray,
  
  /* This is the most generic printing method that is intended to be used by wrappers. */
  member procedure Log(logEvent LoggingEvent),
  
  /* member methods to manager the logger */
  member procedure AddAppender(appender LogAppender),
  member function GetAllAppenders return LogAppender,
  member function GetAppender return LogAppender,
  member procedure RemoveAllAppenders,
  member procedure RemoveAppender(name varchar2),
  member procedure RemoveAppender(appender LogAppender),
  
  member function GetAdditivity return boolean,
  member procedure SetAdditivity(value boolean),
  member function GetEffectiveLevel return LogLevel,
  member function GetLevel return LogLevel,
  member procedure SetLevel(logLevel LogLevel),
  member function GetLoggerRepository return varchar2,
  member function GetName return varchar2,
  member function GetParent return Logger,
  member function IsEnabledFor(logLevel LogLevel) return boolean
  
)
not final not instantiable;
/
