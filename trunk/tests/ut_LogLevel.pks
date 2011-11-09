create or replace
package ut_LogLevel is
  procedure ut_setup;
  procedure ut_teardown;
 
  procedure ut_Properties;
  procedure ut_ConstructorKnown;
  procedure ut_ConstructorUnKnown;
  procedure ut_Compare;
end ut_LogLevel;
/