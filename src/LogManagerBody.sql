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
package body LogManager as
  
  function GetLogger(name varchar2) return ILog is
    m_log LogImpl;
  begin
    m_log := LogImpl(LogRepository.GetLogger(name));
    return m_log;
  end;

  function GetCurrentLoggers return LoggerArray is
  begin
    raise LogUtil.NotImplementedException; 
  end;
  
  function Exists(name varchar2) return ILog is
  begin
  	null;
  end;
  
  procedure ResetConfiguration is
  begin
    null;
  end;
  
  procedure Shutdown is
  begin
    null;
  end;

end LogManager;
/
