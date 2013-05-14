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
type AppenderSkeleton as object
(
	/**
	* This object provides the code for common functionality, such as support 
	* for threshold filtering and support for general filters.
	* @headcom
	*/
	
	/**
	* The layout variable does not need to be set if the appender 
	* implementation has its own layout.
	*/
	Layout LayoutSkeleton,
	
	/**
	* Appenders are named.
	*/
	Name varchar2(255),
	
	/**
	* The threshold Level of this appender. There is no level threshold 
	* filtering by default.
	*/
	Treshold LogLevel,
	
	/**
	* Initialize the appender based on the options set.
	* <br/>
	* If any of the configuration properties are modified then 
	* ActivateOptions must be called again.
	*/
	member procedure ActivateOptions,
	
	/**
	* Performs threshold checks and invokes filters before delegating actual 
	* logging to the subclasses specific Append method.
	* @param loggingEvent The event to log.
	*/
	member procedure DoAppend(loggingEvent LoggingEvent),
	
	/**
	* Helper method to render a LoggingEvent to a string. This appender must 
	* have a Layout set to render the loggingEvent to a string.
	* <br/>
	* If there is exception data in the logging event and 
	* the layout does not process the exception, this method 
	* will append the exception text to the rendered string.
	* @param loggingEvent The event to render.
	*/
	member function RenderLoggingEvent(loggingEvent LoggingEvent) return varchar2,
	
	/**
	* A subclass must implement this method to perform logging of the 
	* loggingEvent. 
	* <br />
	* This method will be called by DoAppend if all the conditions 
	* listed for that method are met. To restrict the logging of events
	* in the appender override the PreAppendCheck method.
	* @param loggingEvent The event to log.
	*/
	not final member procedure Append(loggingEvent LoggingEvent),
	
	/**
	* Gets the unit name of the appender which is needed for error
	* log output. This function should always return $$PLSQL_UNIT.
	* @return The unit name of the appender.
	*/
	not final member function GetUnitName return varchar2
	
)
not final not instantiable;
/
