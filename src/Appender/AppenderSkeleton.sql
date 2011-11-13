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
	* This class provides the code for common functionality, such as support 
	* for threshold filtering and support for general filters.
	* <br />
	* Appenders can also implement the IOptionHandler interface. Therefore 
	* they would require that the ActivateOptions method be called after the 
	* appenders properties have been configured.
	*
	* @headcom
	*/

	/**
	* The name of this appender.
	*/
	Name varchar2(255),

	/**
	* The threshold Level of this appender.
	*/
	Treshold LogLevel,

	/**
	* Performs threshold checks and invokes filters before delegating actual 
	* logging to the subclasses specific Append method.
	*
	* @param loggingEvent The event to log.
	*/
	member procedure DoAppend(loggingEvent LoggingEvent),
	
	/**
	* A subclass must implement this method to perform logging of the 
	* loggingEvent. 
	* <br />
	* This method will be called by DoAppend if all the conditions 
	* listed for that method are met. To restrict the logging of events in the 
	* appender override the PreAppendCheck method.
	*
	* @param loggingEvent The event to log.
	*/
	not final member procedure Append(loggingEvent LoggingEvent)
)
not final not instantiable;
/
