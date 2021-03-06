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
package body BasicConfigurator as
	
	procedure Configure is
		l_appender ConsoleAppender;
		l_layout PatternLayout;
	begin
		l_appender := ConsoleAppender('root');
		l_layout := new PatternLayout();
		l_layout.ConversionPattern := LogUtil.DetailConversionPattern;
		l_layout.ActivateOptions;
		l_appender.Layout := l_layout;
		Configure(l_appender);
	end;

	procedure Configure(appender AppenderSkeleton) is
	begin
		Configure(AppenderArray(appender));
	end;

	procedure Configure(appenders AppenderArray) is
	begin
		Hierarchy.Root.RemoveAllAppenders;
		LogLog.ResetErrorHandler;
		for i in appenders.FIRST..appenders.LAST loop
			if appenders.EXISTS(i) then
				Hierarchy.Root.AddAppender(appenders(i));
			end if;
		end loop;
	end;
	
end BasicConfigurator;
/
