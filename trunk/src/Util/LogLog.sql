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
	* Outputs log statements from within the log4net assembly.
	* <br />
	* Log4net components cannot make log4net logging calls. However, it is
	* sometimes useful for the user to learn about what log4net is
	* doing.
	* <br />
	* All log4net internal debug calls go to the standard output stream
	* whereas internal error messages are sent to the standard error output 
	* stream.
	*
	* @headcom
	*/
	
	/**
	* Gets or sets a value indicating whether log4oracle-plsql internal logging
	* is enabled or disabled.
	* <br />
	* When set to true, internal debug level logging will be displayed.
	*/
	InternalDebugging boolean;
	
	/**
	* Gets or sets a value indicating whether log4oracle-plsql should generate no output
	* from internal logging, not even for errors. 
	* <br />
	* When set to true will cause internal logging at all levels to be 
	* suppressed. This means that no warning or error reports will be logged. 
	* This option overrides the "InternalDebugging" setting and 
	* disables all debug also.
	*/
	QuietMode boolean;
	
	/**
	* Gets or sets a value to emit internal messages or not.
	*/
	EmitInternalMessages boolean;
	
	/**
	* Collection of messages as return value.
	*/
	type StringCollection is table of varchar2(4000)
	  index by binary_integer;
	/**
	* Test if LogLog.Debug is enabled for output.
	* @return true if LogLog.Debug is enabled for output.
	*/
	function IsDebugEnabled return boolean;
	
	/**
	* Writes log4oracle-plsql internal debug messages to the standard output stream.
	* @param message The message to log.
	*/
	procedure Debug(message varchar2);
	
	/**
	* Writes log4oracle-plsql internal debug messages to the standard output stream.
	* @param message The message to log.
	* @return Collection of output lines.
	*/
	function Debug(message varchar2) return StringCollection;
	
	/**
	* Writes log4oracle-plsql internal debug messages to the standard output stream.
	* @param message The message to log.
	* @param error An exception to log.
	*/
	procedure Debug(message varchar2, error varchar2);
	
	/**
	* Writes log4oracle-plsql internal debug messages to the standard output stream.
	* @param message The message to log.
	* @param error An exception to log.
	* @return Collection of output lines.
	*/
	function Debug(message varchar2, error varchar2) return StringCollection;
	
	/**
	* Test if LogLog.Warn is enabled for output.
	* @return true if LogLog.Warn is enabled for output.
	*/
	function IsWarnEnabled return boolean;
	
	/**
	* Writes log4oracle-plsql internal warn messages to the standard output stream.
	* @param message The message to log.
	*/
	procedure Warn(message varchar2);
	
	/**
	* Writes log4oracle-plsql internal warn messages to the standard output stream.
	* @param message The message to log.
	* @return Collection of output lines.
	*/
	function Warn(message varchar2) return StringCollection;
	
	/**
	* Writes log4oracle-plsql internal warn messages to the standard output stream.
	* @param message The message to log.
	* @param error An exception to log.
	*/
	procedure Warn(message varchar2, error varchar2);
	
	/**
	* Writes log4oracle-plsql internal warn messages to the standard output stream.
	* @param message The message to log.
	* @param error An exception to log.
	* @return Collection of output lines.
	*/
	function Warn(message varchar2, error varchar2) return StringCollection;
	
	/**
	* Test if LogLog.Error is enabled for output.
	* @return true if LogLog.Error is enabled for output.
	*/
	function IsErrorEnabled return boolean;
	
	/**
	* Writes log4oracle-plsql internal error messages to the standard output stream.
	* @param message The message to log.
	*/
	procedure Error(message varchar2);
	
	/**
	* Writes log4oracle-plsql internal error messages to the standard output stream.
	* @param message The message to log.
	* @return Collection of output lines.
	*/
	function Error(message varchar2) return StringCollection;
	
	/**
	* Writes log4oracle-plsql internal error messages to the standard output stream.
	* @param message The message to log.
	* @param error An exception to log.
	*/
	procedure Error(message varchar2, perror varchar2);
	
	/**
	* Writes log4oracle-plsql internal error messages to the standard output stream.
	* @param message The message to log.
	* @param error An exception to log.
	* @return Collection of output lines.
	*/
	function Error(message varchar2, perror varchar2) return StringCollection;
	
end LogLog;
/
