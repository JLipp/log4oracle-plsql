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
		utAssert.eq('CheckLineContent Debug',
		            v_messages(1),
		            'log4oracle-plsql: this is the message line');
		
		v_messages := LogLog.Debug('this is an error', 'with an exception');
		utAssert.eq('CountDebugLines2',
		            v_messages.COUNT,
		            2);
		utAssert.eq('CheckLineContent Debug2',
		            v_messages(1),
		            'log4oracle-plsql: this is an error');
		utAssert.eq('CheckLineContent DebugError',
		            v_messages(2),
		            'with an exception');
	end;
	
	procedure ut_DebugModes is
		v_messages LogLog.StringCollection;
	begin
		ut_setup;
		LogLog.QuietMode := false;
		LogLog.InternalDebugging := false;
		v_messages := LogLog.Debug('this is the message line');
		utAssert.eq('CountDebugLines everything false',
		            v_messages.COUNT,
		            0);
		
		LogLog.QuietMode := true;
		LogLog.InternalDebugging := false;
		v_messages := LogLog.Debug('this is the message line');
		utAssert.eq('CountDebugLines QuietMode true',
		            v_messages.COUNT,
		            0);

		LogLog.QuietMode := true;
		LogLog.InternalDebugging := true;
		v_messages := LogLog.Debug('this is the message line');
		utAssert.eq('CountDebugLines everything true',
		            v_messages.COUNT,
		            0);
	end;
	
	procedure ut_Warn is
		v_messages LogLog.StringCollection;
	begin
		ut_setup;
		LogLog.QuietMode := false;
		LogLog.InternalDebugging := true;
		
		v_messages := LogLog.Warn('this is the message line');
		utAssert.eq('CountWarnLines',
		            v_messages.COUNT,
		            1);
		utAssert.eq('CheckLineContent Warn',
		            v_messages(1),
		            'log4oracle-plsql:WARN this is the message line');
		
		v_messages := LogLog.Warn('this is an error', 'with an exception');
		utAssert.eq('CountWarnLines2',
		            v_messages.COUNT,
		            2);
		utAssert.eq('CheckLineContent Warn2',
		            v_messages(1),
		            'log4oracle-plsql:WARN this is an error');
		utAssert.eq('CheckLineContent WarnError',
		            v_messages(2),
		            'with an exception');
	end;
	
	procedure ut_WarnModes is
		v_messages LogLog.StringCollection;
	begin
		ut_setup;
		LogLog.QuietMode := false;
		LogLog.InternalDebugging := false;
		v_messages := LogLog.Warn('this is the message line');
		utAssert.eq('CountWarnLines everything false',
		            v_messages.COUNT,
		            1);

		LogLog.QuietMode := true;
		LogLog.InternalDebugging := false;
		v_messages := LogLog.Warn('this is the message line');
		utAssert.eq('CountWarnLines QuiteMode true',
		            v_messages.COUNT,
		            0);

		LogLog.QuietMode := true;
		LogLog.InternalDebugging := true;
		v_messages := LogLog.Warn('this is the message line');
		utAssert.eq('CountWarnLines everything true',
		            v_messages.COUNT,
		            0);
	end;
	
	procedure ut_Error is
		v_messages LogLog.StringCollection;
	begin
		ut_setup;
		LogLog.QuietMode := false;
		LogLog.InternalDebugging := true;
		
		v_messages := LogLog.Error('this is the message line');
		utAssert.eq('CountErrorLines',
		            v_messages.COUNT,
		            1);
		utAssert.eq('CheckLineContent Error',
		            v_messages(1),
		            'log4oracle-plsql:ERROR this is the message line');
		
		raise no_data_found;
	exception
		when no_data_found then
			v_messages := LogLog.Error('this is an error', 'with an exception');
			utAssert.eq('CounterrorLines2',
									v_messages.COUNT,
									2);
			utAssert.eq('CheckLineContent Error2',
									v_messages(1),
									'log4oracle-plsql:ERROR this is an error');
			utAssert.eq('CheckLineContent ErrorError',
									substr(v_messages(2), 1, 17),
									'with an exception');
	end;
	
	procedure ut_ErrorModes is
		v_messages LogLog.StringCollection;
	begin
		ut_setup;
		LogLog.QuietMode := false;
		LogLog.InternalDebugging := false;
		v_messages := LogLog.Error('this is the message line');
		utAssert.eq('CountWarnLines everything false',
		            v_messages.COUNT,
		            1);

		LogLog.QuietMode := true;
		LogLog.InternalDebugging := false;
		v_messages := LogLog.Error('this is the message line');
		utAssert.eq('CountWarnLines QuietMode true',
		            v_messages.COUNT,
		            0);

		LogLog.QuietMode := true;
		LogLog.InternalDebugging := true;
		v_messages := LogLog.Error('this is the message line');
		utAssert.eq('CountWarnLines everything true',
		            v_messages.COUNT,
		            0);
	end;
	
	procedure ut_ErrorHandler is
		v_messages LogLog.StringCollection;
		v_prefix1 varchar2(20) := 'pref1';
		v_prefix2 varchar2(20) := 'pref2';
	begin
		ut_setup;
		LogLog.QuietMode := false;
		LogLog.InternalDebugging := true;
		LogLog.ResetErrorHandler;
		v_messages := LogLog.ErrorHandler(v_prefix1, 'This line is printed!');
		utAssert.eq('First ErrorHandler line',
		            v_messages.COUNT,
		            1);
		v_messages := LogLog.ErrorHandler(v_prefix1, 'This line is not printed because second line.');
		utAssert.eq('Second ErrorHandler line',
		            v_messages.COUNT,
		            0);
		v_messages := LogLog.ErrorHandler(v_prefix2, 'This line is printed because different prefix.');
		utAssert.eq('Next ErrorHandler line differnt prefix',
		            v_messages.COUNT,
		            1);
	end;
	
end ut_LogLog;
/