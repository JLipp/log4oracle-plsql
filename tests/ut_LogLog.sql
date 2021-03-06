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
package ut_LogLog is
	procedure ut_setup;
	procedure ut_teardown;

	procedure ut_IsValuesCheck;
	procedure ut_Debug;
	procedure ut_DebugModes;
	procedure ut_Warn;
	procedure ut_WarnModes;
	procedure ut_Error;
	procedure ut_ErrorModes;
	procedure ut_ErrorHandler;
end ut_LogLog;
/