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
package body ut_LogLog is
	
	procedure ut_setup is
	begin
		LogLog.InternalDebugging := false;
		LogLog.QuietMode := false;
		LogLog.EmitInternalMessages := true;
	end;
	
	procedure ut_teardown is
	begin
		null;
	end;
	
	procedure ut_IsValuesCheck is
	begin
		ut_setup;
		
		utAssert.eq('IsDebugEnabled',
		            LogLog.IsDebugEnabled,
		            false);
		utAssert.eq('IsWarnEnabled',
		            LogLog.IsWarnEnabled,
		            true);
		utAssert.eq('IsErrorEnabled',
		            LogLog.IsErrorEnabled,
		            true);
		
		LogLog.QuietMode := true;
		utAssert.eq('IsDebugEnabled',
		            LogLog.IsDebugEnabled,
		            false);
		utAssert.eq('IsWarnEnabled',
		            LogLog.IsWarnEnabled,
		            false);
		utAssert.eq('IsErrorEnabled',
		            LogLog.IsErrorEnabled,
		            false);
		
		LogLog.QuietMode := false;
		LogLog.InternalDebugging := true;
		utAssert.eq('IsDebugEnabled',
		            LogLog.IsDebugEnabled,
		            true);
		utAssert.eq('IsWarnEnabled',
		            LogLog.IsWarnEnabled,
		            true);
		utAssert.eq('IsErrorEnabled',
		            LogLog.IsErrorEnabled,
		            true);
	end;
	
	procedure ut_Debug is
		v_messages LogLog.StringCollection;
	begin
		ut_setup;
		LogLog.QuietMode := false;
		LogLog.InternalDebugging := true;
		
		v_messages := LogLog.Debug('this is the message line');
		utAssert.eq('CountDebugLines',
		            v_messages.COUNT,
		            1);
		utAssert.eq('CheckLineContent',
		            v_messages(1),
		            'log4oracle-plsql: this is the message line');
		
		v_messages := LogLog.Debug('this is an error', 'with an exception');
		utAssert.eq('CountDebugLines',
		            v_messages.COUNT,
		            2);
		utAssert.eq('CheckLineContent',
		            v_messages(1),
		            'log4oracle-plsql: this is an error');
		utAssert.eq('CheckLineContent',
		            v_messages(2),
		            'with an exception');
	end;
	
	procedure ut_Warn is
		v_messages LogLog.StringCollection;
	begin
		ut_setup;
		LogLog.QuietMode := false;
		LogLog.InternalDebugging := true;
		
		v_messages := LogLog.Warn('this is the message line');
		utAssert.eq('CountDebugLines',
		            v_messages.COUNT,
		            1);
		utAssert.eq('CheckLineContent',
		            v_messages(1),
		            'log4oracle-plsql:WARN this is the message line');
		
		v_messages := LogLog.Warn('this is an error', 'with an exception');
		utAssert.eq('CountDebugLines',
		            v_messages.COUNT,
		            2);
		utAssert.eq('CheckLineContent',
		            v_messages(1),
		            'log4oracle-plsql:WARN this is an error');
		utAssert.eq('CheckLineContent',
		            v_messages(2),
		            'with an exception');
	end;
	
	procedure ut_Error is
		v_messages LogLog.StringCollection;
	begin
		ut_setup;
		LogLog.QuietMode := false;
		LogLog.InternalDebugging := true;
		
		v_messages := LogLog.Error('this is the message line');
		utAssert.eq('CountDebugLines',
		            v_messages.COUNT,
		            1);
		utAssert.eq('CheckLineContent',
		            v_messages(1),
		            'log4oracle-plsql:ERROR this is the message line');
		
		v_messages := LogLog.Error('this is an error', 'with an exception');
		utAssert.eq('CountDebugLines',
		            v_messages.COUNT,
		            2);
		utAssert.eq('CheckLineContent',
		            v_messages(1),
		            'log4oracle-plsql:ERROR this is an error');
		utAssert.eq('CheckLineContent',
		            v_messages(2),
		            'with an exception');
	end;
	
end ut_LogLog;
/