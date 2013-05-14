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
type body AQAppender as

	constructor function AQAppender(name varchar2, qname varchar2) return self as result as
	begin
		self.Name := name;
		self.QueueName := qname;
		self.Threshold := LogLevel.Debug;
		return;
	end;
	
	overriding member procedure Append(loggingEvent LoggingEvent) as

    no_subscribers EXCEPTION;
    PRAGMA EXCEPTION_INIT(no_subscribers, -60);

     vEnqueue_options    dbms_aq.enqueue_options_t;
     vMessage_properties dbms_aq.message_properties_t;
     vMsgid              raw(16);
     
    BEGIN

    vEnqueue_options.visibility := dbms_aq.IMMEDIATE;
    --vEnqueue_options.delivery_mode := dbms_aq.PERSISTENT;
    --vEnqueue_options.delivery_mode := dbms_aq.PERSISTENT_OR_BUFFERED;
    vMessage_properties.priority :=  -self.Threshold.value;
    --vMessage_properties.user_property :=  ????
    
    
    dbms_aq.enqueue ( queue_name         => 'log_queue',
                        enqueue_options    => vEnqueue_options,
                        message_properties => vMessage_properties,
                        payload            => loggingevent,
                        msgid              => vMsgid
                        );

    EXCEPTION
        WHEN no_subscribers THEN
            LogLog.warn('no subscribers');
            NULL; --do nothing

	end;
	
	overriding member function GetUnitName return varchar2 as
	begin
		return $$PLSQL_UNIT;
	end;
	
end;
/
