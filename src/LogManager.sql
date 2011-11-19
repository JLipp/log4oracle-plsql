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
	* <a href="http://logging.apache.org/log4j/1.2/manual.html#defaultInit">
	* log4j manual</a>.
	* @headcom
	*/
	
	/** 
	* Returns the named logger if it exists.
	* @param name The fully qualified logger name to look for.
	* @return The logger found, or null if no logger could be found.
	*/
	function Exists(name varchar2) return Logger;
	
	/** 
	* Returns all the currently defined loggers in the default repository.
	* The root logger is not included in the returned array.
	* @return All the defined loggers.
	*/
	function GetCurrentLoggers return LoggerArray;

	/** 
	* Retrieves a logger named as the name parameter. If the named logger
	* already exists, then the existing instance will be returned. Otherwise, a 
	* new instance is created. By default, loggers do not have a set level but 
	* inherit it from the hierarchy. This is one of the central features of 
	* log4oracle-plsql.
	* @param name The name of the logger to retrieve.
	* @return The logger with the name specified.
	*/
	function GetLogger(name varchar2) return Logger;

	/** 
	* Resets all values contained in this repository instance to their defaults.
	* This removes all appenders from all loggers, sets the level of all 
	* non-root loggers to null, sets their additivity flag to true and sets the 
	* level of the root logger to Debug. Moreover, message disabling is set to 
	* its default "off" value.
	*/
	procedure ResetConfiguration;

	/** 
	* Calling this method will safely close and remove all appenders in all the
	* loggers including root contained in all the default repositories.
	* Some appenders need to be closed before the application exists. Otherwise, 
	* pending logging events might be lost.
	* The shutdown method is careful to close nested appenders before closing 
	* regular appenders. This is allows configurations where a regular appender 
	* is attached to a logger and again to a nested appender.
	*/
	procedure Shutdown;

end LogManager;
/
