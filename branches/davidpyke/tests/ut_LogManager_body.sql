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
package body ut_LogManager is
	
	mylog Logger;
	
	procedure ut_setup is
	begin
		mylog := LogManager.GetLogger('ut');
	end;
	 
	procedure ut_teardown is
	begin
		null;
	end;
	
	procedure ut_ConfigureBasic is
	begin
		null;
	end;
	
	procedure ut_ConfigureXML is
	begin
		null;
	end;
	
	procedure ut_Exists is
		testlog Logger;
	begin
		/*
		testlog := LogManager.Exists('ut');
		utAssert.eq('logger exists',
		            true,
		            false);
		testlog := LogManager.Exists('doesnotexist');
		utAssert.isnull('logger does not exist',
		                testlog.m_logger.m_name);
		begin
			testlog := LogManager.Exists(null);
			utAssert.isnull('logger does not exist',
		                  testlog.m_logger.m_name);
		exception
			when LogUtil.ArgumentNullException then
				utAssert.eq('ArgumentNullExcetion raised due to missing logger name',
		                true,
		                true);
		end;
		*/
		null;
	end;
	
	procedure ut_GetLogger is
	begin
		mylog := LogManager.GetLogger('ut');
		utAssert.eq('loggers exists',
		            mylog.m_name,
		            'ut');
	end;
	
	procedure ut_ResetConfiguration is
	begin
		null;
	end;
	
	procedure ut_Shutdown is
	begin
		null;
	end;
	
end ut_LogManager;
/