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
package body LogUtil as
  
  procedure LogLogDebug(message varchar2) as
  begin
    dbms_output.put_line('[DEBUG] - '||message);
  end;
  
  procedure LogLogError(message varchar2) as
  begin
    dbms_output.put_line('[ERROR] - '||message);  
  end;

end LogUtil;
/
