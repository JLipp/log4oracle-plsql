/** 
* Copyright 2011 David Pyke Le Brun
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
type AQAppender under AppenderSkeleton
(
	/**
	* AQAppender appends log events to a Advanced Stream (AQ) queue
	* <br />
	* <br />
	*
	* @headcom
	*/

	/**
	*  Name of Queue to append to
	*/
	QueueName varchar2(255),


	/**
	* Initializes a new instance of the AQAppender class.
	*/
	constructor function AQAppender(name varchar2 default null, qname varchar2 default null) return self as result,

	/**
	* Writes the event to the queue.
	* <br />
	* The format of the output will depend on the appender's layout.
	*
	* @param loggingEvent The event to log.
	*/
	overriding member procedure Append(loggingEvent LoggingEvent),
	
	/**
	* Gets the unit name of the appender which is needed for error
	* log output. This function should always return $$PLSQL_UNIT.
	* @return The unit name of the appender.
	*/
	overriding member function GetUnitName return varchar2
	
)
final instantiable;
/
