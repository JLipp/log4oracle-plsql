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
type Logger as object
( 
	/**
	* 
	* @headcom
	*/

	/* Private fields */
	m_additive number,
	m_level LogLevel,
	m_name varchar2(255),
	m_parent anydata,
	m_appenders AppenderArray,
	
	/**
	* Checks if this logger is enabled for the Debug level.
	*/
	member function IsDebugEnabled return boolean,

	/**
	* Checks if this logger is enabled for the Info level.
	*/
	member function IsInfoEnabled return boolean,

	/**
	* Checks if this logger is enabled for the Warn level.
	*/
	member function IsWarnEnabled return boolean,

	/**
	* Checks if this logger is enabled for the Error level.
	*/
	member function IsErrorEnabled return boolean,

	/**
	* Checks if this logger is enabled for the Fatal level.
	*/
	member function IsFatalEnabled return boolean,
	
	/**
	* Log a message with the Debug level.
	* @param message The message to log.
	* @param showError Display error and stack in log file, default false.
	*/
	member procedure Debug(message varchar2, showError boolean default false),

	/**
	* Log a message with the Info level.
	* @param message The message to log.
	* @param showError Display error and stack in log file, default false.
	*/
	member procedure Info(message varchar2, showError boolean default false),

	/**
	* Log a message with the Error level.
	* @param message The message to log.
	* @param showError Display error and stack in log file, default true.
	*/
	member procedure Error(message varchar2, showError boolean default true),

	/**
	* Log a message with the Warn level.
	* @param message The message to log.
	* @param showError Display error and stack in log file, default false.
	*/
	member procedure Warn(message varchar2, showError boolean default false),

	/**
	* Log a message with the Fatal level.
	* @param message The message to log.
	* @param showError Display error and stack in log file, default true.
	*/
	member procedure Fatal(message varchar2, showError boolean default true),

	
	/* This is the most generic printing method that is intended to be used by wrappers. */
	member procedure Log(logEvent LoggingEvent),
	
	/* member methods to manager the logger */
	member procedure AddAppender(appender AppenderSkeleton),
	member function GetAllAppenders return AppenderArray,
	member function GetAppender(name varchar2) return AppenderSkeleton,
	member procedure RemoveAllAppenders,
	member procedure RemoveAppender(name varchar2),
	member procedure RemoveAppender(appender AppenderSkeleton),
	
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
