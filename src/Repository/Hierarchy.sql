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
package Hierarchy as
	/**
	* Hierarchical organization of loggers
	* The casual user should not have to deal with this class directly.
	* This class is specialized in retrieving loggers by name and also maintaining 
	* the logger hierarchy. Implements the ILoggerRepository interface.
	* The structure of the logger hierarchy is maintained by the GetLogger method. 
	* The hierarchy is such that children link to their parent but parents do not 
	* have any references to their children. Moreover, loggers can be instantiated 
	* in any order, in particular descendant before ancestor.
	* In case a descendant is created before a particular ancestor, then it creates
	* a provision node for the ancestor and adds itself to the provision node.
	* Other descendants of the same ancestor add themselves to the previously 
	* created provision node.
	* @headcom
	*/
	
	/**
	* Flag indicates if this repository has been configured.
	*/
	Configured boolean := false;
	
	/**
	* Has no appender warning been emitted
	*/
	EmittedNoAppenderWarning boolean := false;
	
	/**
	* Repository specific properties
	*/
	--Properties
	
	/**
	* Get the root of this hierarchy
	*/
	Root Logger;
	
	/**
	* The threshold for all events in this repository
	*/
	Treshhold LogLevel;
	
	/**
	* Clear all logger definitions from the internal table
	*/
	procedure Clear;

	/**
	* Test if a logger exists
	* @param name The name of the logger to lookup
	* @return The Logger object with the name specified
	*/
	function Exists(name varchar2) return Logger;

	/**
	* Returns all the Appenders that are currently configured.
	* All the loggers are searched for appenders. The appenders may also be containers for appenders and these are also searched for additional loggers.
	* The list returned is unordered but does not contain duplicates.
	* @return An array containing all the currently configured appenders
	*/
	function GetAppenders return AppenderArray;

	/**
	* Returns all the currently defined loggers in the hierarchy as an Array. The root logger is not included in the returned enumeration.
	* @return All the defined loggers
	*/
	function GetCurrentLoggers return LoggerArray;

	/**
	* The threshold for all events in this repository.
	* Return a new logger instance named as the first parameter using the default factory.
	* If a logger of that name already exists, then it will be returned. Otherwise, a new logger will be instantiated and then linked with its existing ancestors as well as children.
	* @param name The name of the logger to retrieve
	* @return The logger object with the name specified
	*/
	function GetLogger(name varchar2) return Logger;

	/**
	* Test if this hierarchy is disabled for the specified Level.
	* If this hierarchy has not been configured then this method will always return true.
	* This method will return true if this repository is disabled for level object passed as parameter and false otherwise.
	* @param level The level to check against.
	* @return true if the repository is disabled for the level argument, false otherwise.
	*/
	function IsDisabled(level LogLevel) return boolean;
	
	/**
	* Log the logEvent through this hierarchy.
	* This method should not normally be used to log. The ILog interface should be used for routine logging. This interface can be obtained using the GetLogger method.
	* The logEvent is delivered to the appropriate logger and that logger is then responsible for logging the event.
	* @param event the event to log
	*/
	procedure Log (event LoggingEvent);
	
	/**
	* Reset all values contained in this hierarchy instance to their default.
	*/
	procedure ResetConfiguration;
	/**
	* Shutting down a hierarchy will safely close and remove all appenders in all loggers including the root logger.
	*/
	procedure Shutdown;

end Hierarchy;
/
