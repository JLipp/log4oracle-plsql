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
type ExceptionLayout 
FORCE under LayoutSkeleton
(
	/**
	* A Layout that renders only the Exception text from the logging event
	* This Layout should only be used with appenders that utilize multiple
	* layouts (e.g. <see cref="log4net.Appender.AdoNetAppender"/>).
	* @head
	*/
	
	/**
	* Activate component options
	* This is part of the <see cref="IOptionHandler"/> delayed object
	* activation scheme. The <see cref="ActivateOptions"/> method must 
	* be called on this object after the configuration properties have
	* been set. Until <see cref="ActivateOptions"/> is called this
	* object is in an undefined state and must not be used. 
	* If any of the configuration properties are modified then 
	* <see cref="ActivateOptions"/> must be called again.
 	* This method must be implemented by the subclass.
	*/
	overriding member procedure ActivateOptions,
	
	/**
	*Implement this method to create your own layout format.
	* @param event The event to format
	* @return The formatted logging event
	*/
	overriding member function Format(event LoggingEvent) return varchar2,
	
	/**
	* Constructs a SimpleLayout
	*/
	constructor function ExceptionLayout return self as result
	
);
/
