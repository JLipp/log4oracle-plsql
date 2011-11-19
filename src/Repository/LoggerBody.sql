/** 
* Copyright 2011 Juergen Lipp
*	
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
* 
*     http://www.apache.org/licenses/LICENSE-2.0
* 
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

create or replace 
type body Logger as

	member function IsDebugEnabled return boolean as
	begin
		return IsEnabledFor(LogLevel.Debug);
	end;
	
	member function IsErrorEnabled return boolean as
	begin
		return IsEnabledFor(LogLevel.Error);
	end;
	
	member function IsFatalEnabled return boolean as
	begin
		return IsEnabledFor(LogLevel.Fatal);
	end;
	
	member function IsInfoEnabled return boolean as
	begin
		return IsEnabledFor(LogLevel.Info);
	end;
	
	member function IsWarnEnabled return boolean as
	begin
		return IsEnabledFor(LogLevel.Warn);
	end;
	
	member procedure Debug(message varchar2) as
	begin
		Log(LoggingEvent(m_name, LogLevel.Debug, message, null));
	end;
	
	member procedure Debug(message varchar2, error varchar2) as
	begin
		Log(LoggingEvent(m_name, LogLevel.Debug, message, error));
	end;
	
	member procedure Error(message varchar2) as
	begin
		Log(LoggingEvent(m_name, LogLevel.Error, message, null));
	end;
	
	member procedure Error(message varchar2, error varchar2) as
	begin
		Log(LoggingEvent(m_name, LogLevel.Error, message, error));
	end;
	
	member procedure Fatal(message varchar2) as
	begin
		Log(LoggingEvent(m_name, LogLevel.Fatal, message, null));
	end;
	
	member procedure Fatal(message varchar2, error varchar2) as
	begin
		Log(LoggingEvent(m_name, LogLevel.Fatal, message, error));
	end;
	
	member procedure Info(message varchar2) as
	begin
		Log(LoggingEvent(m_name, LogLevel.Info, message, null));
	end;
	
	member procedure Info(message varchar2, error varchar2) as
	begin
		Log(LoggingEvent(m_name, LogLevel.Info, message, error));
	end;
	
	member procedure Warn(message varchar2) as
	begin
		Log(LoggingEvent(m_name, LogLevel.Warn, message, null));
	end;
	
	member procedure Warn(message varchar2, error varchar2) as
	begin
		Log(LoggingEvent(m_name, LogLevel.Warn, message, error));
	end;
	
	member procedure Log(logEvent LoggingEvent) as
		x number;
		c Logger;
		writes number := 0;
	begin

		if logEvent is null then
			raise LogUtil.ArgumentNullException;
		end if;

		c := self;
		while c is not null loop
			if IsEnabledFor(logEvent.LLevel) then
				
				if c.m_appenders.COUNT > 0 then
					for i in c.m_appenders.first..c.m_appenders.last loop
						if c.m_appenders.exists(i) then
							c.m_appenders(i).DoAppend(logEvent);
						end if;
					end loop;
				end if;
			end if;
			writes := writes + c.m_appenders.count;
			
			if not c.GetAdditivity then
				exit;
			end if;
			
			x := c.m_parent.GetObject(c);
		end loop;
		
		if writes = 0 then
			LogLog.Debug('No appenders could be found for logger ['||m_name||']');
			LogLog.Debug('Please initialize the log4oracle-plsql system properly.');
		end if;

	exception
		when others then
			LogLog.Error('Error during Log of messages.', sqlerrm(sqlcode));
	end;

	member procedure AddAppender(appender AppenderSkeleton) as
	begin
		m_appenders.EXTEND(1);
		m_appenders(m_appenders.LAST) := appender;
	end;
	
	member function GetAllAppenders return AppenderArray as
	begin
		return m_appenders;
	end;
	
	member function GetAppender(name varchar2) return AppenderSkeleton as
		l_appender AppenderSkeleton;
	begin
		l_appender := m_appenders(m_appenders.FIRST);
		for i in m_appenders.FIRST..m_appenders.LAST loop
			if m_appenders.EXISTS(i) then
				l_appender := m_appenders(i);
				if l_appender.name = name then
					return l_appender;
				end if;
			end if;
		end loop;
		
		return null;
	end;
	
	member procedure RemoveAllAppenders as
	begin
		m_appenders.DELETE;
	end;
	
	member procedure RemoveAppender(name varchar2) as
	begin
		for i in m_appenders.FIRST..m_appenders.LAST loop
			if m_appenders.EXISTS(i) then
				if m_appenders(i).name = name then
					m_appenders.DELETE(i);
				end if;
			end if;
		end loop;
	end;
	
	member procedure RemoveAppender(appender AppenderSkeleton) as
	begin
		RemoveAppender(appender.name);
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
		if value then
			m_additive := 1;
		else
			m_additive := 0;
		end if;
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
		return m_level;
	end;
	
	member procedure SetLevel(logLevel LogLevel) as
	begin
		m_level := logLevel;
	end;
	
	member function GetLoggerRepository return varchar2 as
	begin
		null;
	end;
	
	member function GetName return varchar2 as
	begin
		return m_name;
	end;
	
	member function GetParent return Logger as
		x number;
		c Logger;
	begin
		x := m_parent.GetObject(c);
		return c;
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
