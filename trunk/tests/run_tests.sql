@@ut_LogLevel.sql
@@ut_LogLevel_body.sql
@@ut_LogManager.sql
@@ut_LogManager_body.sql
@@ut_LogLog.sql
@@ut_LogLog_body.sql

exec utplsql.test ('LogLevel', recompile_in => FALSE);
exec utplsql.test ('LogManager', recompile_in => FALSE);
exec utplsql.test ('LogLog', recompile_in => FALSE);
