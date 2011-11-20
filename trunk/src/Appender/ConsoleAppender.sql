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
type ConsoleAppender under AppenderSkeleton
(
	/**
	* ConsoleAppender appends log events to the standard output stream or the 
	* error output stream using a layout specified by the user.
	* <br />
	* By default, all output is written to the console's standard output stream. 
	* The Target property can be set to direct the output to the error stream.
	* <br />
	* NOTE: This appender writes each message to the System.Console.Out or 
	* System.Console.Error that is set at the time the event is appended. Therefore 
	* it is possible to programmatically redirect the output of this appender 
	* (for example NUnit does this to capture program output). While this is the 
	* desired behavior of this appender it may have security implications in your 
	* application.
	*
	* @headcom
	*/

	/**
	* Initializes a new instance of the ConsoleAppender class.
	*/
	constructor function ConsoleAppender(name varchar2 default null) return self as result,

	/**
	* Writes the event to the console.
	* <br />
	* The format of the output will depend on the appender's layout.
	*
	* @param loggingEvent The event to log.
	*/
	overriding member procedure Append(loggingEvent LoggingEvent)
)
final instantiable;
/
