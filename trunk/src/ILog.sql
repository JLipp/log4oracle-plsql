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
type ILog as object
( 
  /** 
  * Use the LogManager to obtain logger instances that implement this 
  * interface. The GetLogger static method is used to get logger instances.
  * <br />
  * This class contains methods for logging at different levels and also has 
  * properties for determining if those logging levels are enabled in the 
  * current configuration.
  * <br />
  * This interface can be implemented in different ways. This documentation 
  * specifies reasonable behavior that a caller can expect from the actual 
  * implementation, however different implementations reserve the right to 
  * do things differently.
  * 
  * @headcom
  */  
  
  /**
  * Instance of the corresponding logger.
  */
  m_logger Logger,
  
  /**
  * Checks if this logger is enabled for the Debug level.
  */
  member function IsDebugEnabled return boolean,

  /**
  * Checks if this logger is enabled for the Info level.
  */
  member function IsInfoEnabled return boolean,

  /**
  * Checks if this logger is enabled for the Warn level.
  */
  member function IsWarnEnabled return boolean,

  /**
  * Checks if this logger is enabled for the Error level.
  */
  member function IsErrorEnabled return boolean,

  /**
  * Checks if this logger is enabled for the Fatal level.
  */
  member function IsFatalEnabled return boolean,
  
  /**
  * Log a message with the Debug level.
  * @param message The message to log.
  */
  member procedure Debug(message varchar2),

  /**
  * Log a message with the Info level.
  * @param message The message to log.
  */
  member procedure Info(message varchar2),

  /**
  * Log a message with the Error level.
  * @param message The message to log.
  */
  member procedure Error(message varchar2),

  /**
  * Log a message with the Warn level.
  * @param message The message to log.
  */
  member procedure Warn(message varchar2),

  /**
  * Log a message with the Fatal level.
  * @param message The message to log.
  */
  member procedure Fatal(message varchar2),

  /**
  * Log a message with the Debug level including the an exception passed 
  * as a parameter.
  * @param message The message to log.
  * @param error The exception to log.
  */
  member procedure Debug(message varchar2, error varchar2),

  /**
  * Log a message with the Info level including the an exception passed 
  * as a parameter.
  * @param message The message to log.
  * @param error The exception to log.
  */
  member procedure Info(message varchar2, error varchar2),

  /**
  * Log a message with the Warn level including the an exception passed 
  * as a parameter.
  * @param message The message to log.
  * @param error The exception to log.
  */
  member procedure Warn(message varchar2, error varchar2),

  /**
  * Log a message with the Error level including the an exception passed 
  * as a parameter.
  * @param message The message to log.
  * @param error The exception to log.
  */
  member procedure Error(message varchar2, error varchar2),

  /**
  * Log a message with the Fatal level including the an exception passed 
  * as a parameter.
  * @param message The message to log.
  * @param error The exception to log.
  */
  member procedure Fatal(message varchar2, error varchar2)
  
)
not final not instantiable;
/
