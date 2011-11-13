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
	
	procedure EmitOutLine(message varchar2) as
	begin
		dbms_output.put_line(message);
	end;
	
	function IsDebugEnabled return boolean as
	begin
		return (InternalDebugging and not QuietMode);
	end;
	
	procedure Debug(message varchar2) as
	begin
		Debug(message, null);
	end;

	function Debug(message varchar2) return StringCollection as
	begin
		return Debug(message, null);
	end;

	procedure Debug(message varchar2, error varchar2) as
		v_messages StringCollection;
	begin
		v_messages := Debug(message, error);
	end;

	function Debug(message varchar2, error varchar2) return StringCollection as
		v_messages StringCollection;
		v_counter number := 0;
	begin
		if IsDebugEnabled then
			if EmitInternalMessages then
				EmitOutLine(PREFIX || message);
				if error is not null then
				  EmitOutLine(error);
				end if;
			end if;
			v_counter := v_counter + 1;
			v_messages(v_counter) := PREFIX || message;
			if error is not null then
			  v_counter := v_counter + 1;
				v_messages(v_counter) := error;
			end if;
		end if;
		return v_messages;
	end;
	
	function IsWarnEnabled return boolean as
	begin
		return (not QuietMode);
	end;
	
	procedure Warn(message varchar2) as
	begin
		Warn(message, null);
	end;

	function Warn(message varchar2) return StringCollection as
	begin
		return Warn(message, null);
	end;

	procedure Warn(message varchar2, error varchar2) as
		v_messages StringCollection;
	begin
		v_messages := Warn(message, error);
	end;

	function Warn(message varchar2, error varchar2) return StringCollection as
		v_messages StringCollection;
		v_counter number := 0;
	begin
		if IsWarnEnabled then
			if EmitInternalMessages then
				EmitOutLine(WARN_PREFIX || message);
				if error is not null then
				  EmitOutLine(error);
				end if;
			end if;
			v_counter := v_counter + 1;
			v_messages(v_counter) := WARN_PREFIX || message;
			if error is not null then
			  v_counter := v_counter + 1;
				v_messages(v_counter) := error;
			end if;
		end if;
		return v_messages;
	end;
	
	function IsErrorEnabled return boolean as
	begin
		return (not QuietMode);
	end;
	
	procedure Error(message varchar2) as
	begin
		Error(message, null);
	end;

	function Error(message varchar2)  return StringCollection as
	begin
		return Error(message, null);
	end;

	procedure Error(message varchar2, perror varchar2) as
		v_messages StringCollection;
	begin
		v_messages := Error(message, perror);
	end;

	function Error(message varchar2, perror varchar2)  return StringCollection as
		v_messages StringCollection;
		v_counter number := 0;
	begin
		if IsErrorEnabled then
			if EmitInternalMessages then
				EmitOutLine(ERR_PREFIX || message);
				if perror is not null then
				  EmitOutLine(perror);
				end if;
			end if;
			v_counter := v_counter + 1;
			v_messages(v_counter) := ERR_PREFIX || message;
			if perror is not null then
			  v_counter := v_counter + 1;
				v_messages(v_counter) := perror;
			end if;
		end if;
		return v_messages;
	end;

begin
	InternalDebugging := false;
	QuietMode := false;
	EmitInternalMessages := true;
end LogLog;
/
