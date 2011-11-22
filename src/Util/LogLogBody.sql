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
package body LogLog as
	
	PREFIX      constant varchar2(25) := 'log4oracle-plsql: ';
	ERR_PREFIX  constant varchar2(25) := 'log4oracle-plsql:ERROR ';
	WARN_PREFIX constant varchar2(25) := 'log4oracle-plsql:WARN ';
	
	type FirstTimeTable is table of boolean
		index by varchar2(32767);
		
	ErrorHandlerPrefixCounter FirstTimeTable;
	
	procedure EmitOutLine(message varchar2) as
	begin
		dbms_output.put_line(message);
	end;
	
	function ForceLog(prefix varchar2, message varchar2, error varchar2) return Stringcollection as
		v_messages StringCollection;
		v_counter number := 0;
		v_error varchar2(32767);
	begin
		v_error := error;
		if v_error is not null then
			v_error := v_error||LogUtil.CRLF;
		end if;
		v_error := v_error||dbms_utility.format_error_stack||dbms_utility.format_error_backtrace;
		
		if EmitInternalMessages then
			EmitOutLine(prefix || message);
			if v_error is not null then
				EmitOutLine(v_error);
			end if;
		end if;
		v_counter := v_counter + 1;
		v_messages(v_counter) := prefix || message;
		if v_error is not null then
			v_counter := v_counter + 1;
			v_messages(v_counter) := error;
		end if;
		return v_messages;
	end;

	function IsDebugEnabled return boolean as
	begin
		return (InternalDebugging and not QuietMode);
	end;
	
	procedure Debug(message varchar2, error varchar2 default null) as
		v_messages StringCollection;
	begin
		v_messages := Debug(message, error);
	end;

	function Debug(message varchar2, error varchar2 default null) return StringCollection as
		v_messages StringCollection;
	begin
		if IsDebugEnabled then
			v_messages := ForceLog(PREFIX, message, error);
		end if;
		return v_messages;
	end;
	
	function IsWarnEnabled return boolean as
	begin
		return (not QuietMode);
	end;
	
	procedure Warn(message varchar2, error varchar2 default null) as
		v_messages StringCollection;
	begin
		v_messages := Warn(message, error);
	end;

	function Warn(message varchar2, error varchar2 default null) return StringCollection as
		v_messages StringCollection;
	begin
		if IsWarnEnabled then
			v_messages := ForceLog(WARN_PREFIX, message, error);
		end if;
		return v_messages;
	end;
	
	function IsErrorEnabled return boolean as
	begin
		return (not QuietMode);
	end;
	
	procedure Error(message varchar2, perror varchar2 default null) as
		v_messages StringCollection;
	begin
		v_messages := Error(message, perror);
	end;

	function Error(message varchar2, perror varchar2 default null)  return StringCollection as
		v_messages StringCollection;
	begin
		if IsErrorEnabled then
			v_messages := ForceLog(ERR_PREFIX, message, perror);
		end if;
		return v_messages;
	end;
	
	procedure ErrorHandler(prefix varchar2, message varchar2) as
		v_messages StringCollection;
	begin
		v_messages := ErrorHandler(prefix, message);
	end;
	
	function ErrorHandler(prefix varchar2, message varchar2) return StringCollection as
		nullReturn StringCollection;
	begin
		if not ErrorHandlerPrefixCounter.EXISTS(prefix) then
			ErrorHandlerPrefixCounter(prefix) := false;
			if InternalDebugging and not QuietMode then
				return LogLog.Error('['||prefix||'] '||message);
			end if;
		end if;
		return nullReturn;
	end;
	
	procedure ResetErrorHandler as
	begin
		ErrorHandlerPrefixCounter.DELETE;
	end;
	
begin
	/** 
	* Initialize the LogLog internal logging system with default behaviour.
	* Warning and Errors are displayed at the console, debug messages
	* are ignored.
	*/
	InternalDebugging := false;
	QuietMode := false;
	EmitInternalMessages := true;
end LogLog;
/
