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
package BasicConfigurator as
	/** 
	* Use this class to quickly configure a Hierarchy.
	* Allows very simple programmatic configuration of log4net.
	* Only one appender can be configured using this configurator. The appender is set at the root of the hierarchy and all logging events will be delivered to that appender.
	* Appenders can also implement the IOptionHandler interface. Therefore they would require that the ActivateOptions method be called after the appenders properties have been configured.
	* @headcom
	*/
	
	/** 
	* Initializes the log4net system with a default configuration.
	*/
	procedure Configure;

	/** 
	* Initializes the log4net system using the specified appender.
	* @param appender The appender to use to log all logging events.
	*/
	procedure Configure(appender AppenderSkeleton);

	/** 
	* Initializes the log4net system using the specified appenders.
	* @param appenders The appenders to use to log all logging events.
	*/
	procedure Configure(appenders AppenderArray);

end BasicConfigurator;
/
