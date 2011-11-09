create or replace
package body ut_LogLevel is

  logLevelAll LogLevel;
  logLevelDebug LogLevel;
  logLevelInfo LogLevel;
  logLevelWarn LogLevel;
  logLevelError LogLevel;
  logLevelFatal LogLevel;
  logLevelOff LogLevel;

  procedure ut_setup is
  begin
    logLevelAll := LogLevel.AllLevels;
    logLevelDebug := LogLevel.Debug;
    logLevelInfo := LogLevel.Info;
    logLevelWarn := LogLevel.Warn;
    logLevelError := LogLevel.Error;
    logLevelFatal := LogLevel.Fatal;
    logLevelOff := LogLevel.Off;
  end;
   
  procedure ut_teardown is
  begin
    null;
  end;
 
  procedure ut_Properties is
  begin
    utAssert.eq('All level', logLevelAll.Value, 0);
    utAssert.eq('Debug level', logLevelDebug.Value, 30000);
    utAssert.eq('Info level', logLevelInfo.Value, 40000);
    utAssert.eq('Warn level', logLevelWarn.Value, 60000);
    utAssert.eq('Error level', logLevelError.Value, 70000);
    utAssert.eq('Fatal level', logLevelFatal.Value, 110000);
    utAssert.eq('Off level', logLevelOff.Value, 999999);
  end;

  procedure ut_ConstructorKnown is
    llevel LogLevel;
  begin
    llevel := LogLevel(0);
    utAssert.eq('All constructor', llevel.Name, 'ALL');
    llevel := LogLevel(30000);
    utAssert.eq('Debug constructor', llevel.Name, 'DEBUG');
    llevel := LogLevel(40000);
    utAssert.eq('Info constructor', llevel.Name, 'INFO');
    llevel := LogLevel(60000);
    utAssert.eq('Warn constructor', llevel.Name, 'WARN');
    llevel := LogLevel(70000);
    utAssert.eq('Error constructor', llevel.Name, 'ERROR');
    llevel := LogLevel(110000);
    utAssert.eq('Fatal constructor', llevel.Name, 'FATAL');
    llevel := LogLevel(999999);
    utAssert.eq('Off constructor', llevel.Name, 'OFF');
  end;

  procedure ut_ConstructorUnKnown is
    llevel LogLevel;
  begin
    llevel := LogLevel(1);
    utAssert.IsNull('constructor with low value', llevel.Value);
    utAssert.IsNull('constructor with low value name', llevel.Name);
    llevel := LogLevel(9999999);
    utAssert.IsNull('constructor with high value', llevel.Value);
    utAssert.IsNull('constructor with high value name', llevel.Name);
    llevel := LogLevel(12345);
    utAssert.IsNull('constructor with value between', llevel.Value);
    utAssert.IsNull('constructor with value between name', llevel.Name);
  end;
  
  procedure ut_Compare is
  begin
    utAssert.eq('compare levels', (logLevelDebug < logLevelInfo), true);
    utAssert.eq('compare levels', (logLevelWarn > logLevelInfo), true);
  end;
  
end ut_LogLevel;
/