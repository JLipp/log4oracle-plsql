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
package LogLog as
	/** 
	* Outputs log statements from within log4oracle-plsql.
	* <br />
	* Log4oracle-plsql components cannot make log4oracle-plsql logging calls.
	* However, it is sometimes useful for the user to learn about what 
	* the log4oracle-plsql is doing.
	* <br />
	* All log4oracle-plsql internal warning and error calls are displayed
	* on the console using DBMS_OUTPUT. Debug messages are only shown if
	* InternalDebugging is enabled. As well you can get a list of messages
	* using the return value of the methods.
	*
	* @headcom
	*/
	
	/**
	* Gets or sets a value indicating whether log4oracle-plsql internal
	* logging is enabled or disabled.
	* <br />
	* When set to true, internal debug level logging will be displayed.
	*/
	InternalDebugging boolean;
	
	/**
	* Gets or sets a value indicating whether log4oracle-plsql should
	* generate no output from internal logging, not even for errors. 
	* <br />
	* When set to true will cause internal logging at all levels to be 
	* suppressed. This means that no warning or error reports will be
	* logged. This option overrides the "InternalDebugging" setting and 
	* disables all debug also.
	*/
	QuietMode boolean;
	
	/**
	* Gets or sets a value to emit internal messages or not.
	*/
	EmitInternalMessages boolean;
	
	/**
	* Collection of messages to return.
	*/
	type StringCollection is table of varchar2(32767)
	  index by binary_integer;
	/**
	* Test if LogLog.Debug is enabled for output.
	* @return True if LogLog.Debug is enabled for output.
	*/
	function IsDebugEnabled return boolean;
	
	/**
	* Writes log4oracle-plsql internal debug messages to the console.
	* @param message The message to log.
	* @param error An exception text to log.
	*/
	procedure Debug(message varchar2, error varchar2 default null);
	
	/**
	* Writes log4oracle-plsql internal debug messages to the console.
	* @param message The message to log.
	* @param error An exception text to log.
	* @return Collection of output lines.
	*/
	function Debug(message varchar2, error varchar2 default null) return StringCollection;
	
	/**
	* Test if LogLog.Warn is enabled for output.
	* @return True if LogLog.Warn is enabled for output.
	*/
	function IsWarnEnabled return boolean;
	
	/**
	* Writes log4oracle-plsql internal warn messages to the console.
	* @param message The message to log.
	* @param error An exception text to log.
	*/
	procedure Warn(message varchar2, error varchar2 default null);
	
	/**
	* Writes log4oracle-plsql internal warn messages to the console.
	* @param message The message to log.
	* @param error An exception text to log.
	* @return Collection of output lines.
	*/
	function Warn(message varchar2, error varchar2 default null) return StringCollection;
	
	/**
	* Test if LogLog.Error is enabled for output.
	* @return True if LogLog.Error is enabled for output.
	*/
	function IsErrorEnabled return boolean;
	
	/**
	* Writes log4oracle-plsql internal error messages to the console.
	* @param message The message to log.
	* @param perror An exception text to log.
	*/
	procedure Error(message varchar2, perror varchar2 default null);
	
	/**
	* Writes log4oracle-plsql internal error messages to the console.
	* @param message The message to log.
	* @param perror An exception text to log.
	* @return Collection of output lines.
	*/
	function Error(message varchar2, perror varchar2 default null) return StringCollection;
	
	/**
	* Implements default error handling policy which consists of
	* eimitting a message for the first error in an appender and
	* ignoring all subsequent errors.
	* <br/>
	* The package saves a counter per perfix parameter and only
	* logs the error if it is the very first cause per object.
	* @param prefix The object where the error occured.
	* @param message The message to log.
	*/
	procedure ErrorHandler(prefix varchar2, message varchar2);

	/**
	* Implements default error handling policy which consists of
	* eimitting a message for the first error in an appender and
	* ignoring all subsequent errors.
	* <br/>
	* The package saves a counter per perfix parameter and only
	* logs the error if it is the very first cause per object.
	* @param prefix The object where the error occured.
	* @param message The message to log.
	* @return Collection of output lines.
	*/
	function ErrorHandler(prefix varchar2, message varchar2) return StringCollection;
	
	/**
	* Reset the error handler back to its initial disabled state.
	*/
	procedure ResetErrorHandler;
	
end LogLog;
/
