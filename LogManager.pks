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
package LogManager as
  /** 
  * Use the LogManager class to retreive ILog instances or to operate on the 
  * current LogRepository. When the LogManager class is loaded into memory 
  * the default initalzation procedure is inititated. The default intialization 
  * procedure is described in the short 
  * <a href="http://logging.apache.org/log4j/1.2/manual.html#defaultInit">log4j manual</a>.
  * @headcom
  */  
  
  NotImplementedException exception;
    
  /** 
  * Returns the named logger if it exists.
  */
  procedure ConfigureBasic;

  /** 
  * Returns the named logger if it exists.
  * @param config The fully qualified logger name to look for.
  */
  procedure ConfigureXML(config XMLType);

  /** 
  * Returns the named logger if it exists.
  * @param name The fully qualified logger name to look for.
  * @return The logger found, or null if no logger could be found.
  */
  function Exists(name varchar2) return ILog;
  --function GetCurrentLoggers return LoggerArray;

  /** 
  * Returns the named logger if it exists.
  * @param name The fully qualified logger name to look for.
  * @return The logger found, or null if no logger could be found.
  */
  function GetLogger(name varchar2) return ILog;

  /** 
  * Returns the named logger if it exists.
  */
  procedure ResetConfiguration;

  /** 
  * Returns the named logger if it exists.
  */
  procedure Shutdown;

end LogManager;
/
