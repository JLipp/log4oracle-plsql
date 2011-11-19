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
package body Hierarchy as

  m_ht LoggerArray;
	
	procedure Clear is
	begin
		raise LogUtil.NotImplementedException; 
	end;
	
	function Exists(name varchar2) return Logger is
	begin
		raise LogUtil.NotImplementedException; 
	end;
	
	function GetAppenders return AppenderArray is
	begin
		raise LogUtil.NotImplementedException; 
	end;
	
	function GetCurrentLoggers return LoggerArray is
	begin
		raise LogUtil.NotImplementedException; 
	end;
	
	function GetLogger(name varchar2) return Logger is
	begin
		if Hierarchy.Root is null then
			Hierarchy.Root := LoggerImpl(0, LogLevel.Debug, 'root', null, AppenderArray());
		end if;
		return LoggerImpl(1, null, name, anydata.ConvertObject(Hierarchy.Root), AppenderArray());
	end;
	
	function IsDisabled(level LogLevel) return boolean is
	begin
		raise LogUtil.NotImplementedException; 
	end;
	
	procedure Log (event LoggingEvent) is
	begin
		raise LogUtil.NotImplementedException; 
	end;
	
	procedure ResetConfiguration is
	begin
		raise LogUtil.NotImplementedException; 
	end;
	
	procedure Shutdown is
	begin
		raise LogUtil.NotImplementedException; 
	end;

end Hierarchy;
/
