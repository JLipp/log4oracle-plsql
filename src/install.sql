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

clear screen
set termout off
set echo off
set verify off
set feedback off 
set ttitle off
set serveroutput on size 1000000 format wrapped
set define on

define line1='------------------------------------------------------------------------'
define line2='========================================================================'
define finished='.                            Finished'

column col noprint new_value ut_owner
select user col from dual;

column col noprint new_value txt_prompt
select 'I N S T A L L A T I O N' col from dual;

set termout on
prompt &line2
prompt Copyright 2011 Juergen Lipp
prompt 
prompt Licensed under the Apache License, Version 2.0 (the "License");
prompt you may not use this file except in compliance with the License.
prompt You may obtain a copy of the License at
prompt 
prompt     http://www.apache.org/licenses/LICENSE-2.0
prompt 
prompt Unless required by applicable law or agreed to in writing, software
prompt distributed under the License is distributed on an "AS IS" BASIS,
prompt WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
prompt See the License for the specific language governing permissions and
prompt limitations under the License.
prompt &line2
prompt 

prompt [ &txt_prompt ]

set termout off
set echo off
set verify off
set feedback off
set ttitle off
set define on
set serveroutput on size 1000000 format wrapped
set termout on

prompt &line1
prompt Droping existing log4oracle-plsql objects
prompt &line1
drop package LogManager;
drop package LogRepository;
drop type ConsoleAppender;
drop type LogImpl;
drop type ILog;
drop type LoggerImpl;
drop type LoggerArray;
drop type Logger;
drop type AppenderArray;
drop type AppenderSkeleton;
drop type LoggingEvent;
drop type LogLevel;
drop package LogUtil;

prompt &line1
prompt Creating log4oracle-plsql objects
prompt &line1
@@Util/LogUtil.sql
@@Util/LogUtilBody.sql
@@Util/LogLog.sql
@@Util/LogLogBody.sql
@@Core/LogLevel.sql
@@Core/LogLevelBody.sql
@@Core/LoggingEvent.sql
@@Core/LoggingEventBody.sql
@@Appender/AppenderSkeleton.sql
@@Appender/AppenderSkeletonBody.sql
@@Appender/AppenderArray.sql
@@Repository/Logger.sql
@@Repository/LoggerBody.sql
@@Repository/LoggerImpl.sql
@@Repository/LoggerArray.sql
@@ILog.sql
@@ILogBody.sql
@@LogImpl.sql
@@Appender/ConsoleAppender.sql
@@Appender/ConsoleAppenderBody.sql
@@Repository/LogRepository.sql
@@Repository/LogRepositoryBody.sql
@@LogManager.sql
@@LogManagerBody.sql

prompt &finished
set feedback on
