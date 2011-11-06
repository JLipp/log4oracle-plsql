--
-- Copyright 2011 Jürgen Lipp
-- 
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--     http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
create or replace
type LogLevel as object
(
	/* The display name of this level. */
	DisplayName varchar2(255),
	/* The name of this level. */
	Name varchar2(255),
	/* The value of this level. */
	Value number,

	constructor function LogLevel(level binary_integer) return self as result,
	
	/* Returns log level value as an indication of relative values to be sortable. */
	map member function Compare return binary_integer,

	static function AllLevels return LogLevel,
	static function Debug return LogLevel,
	static function Info return LogLevel,
	static function Warn return LogLevel,
	static function Error return LogLevel,
	static function Fatal return LogLevel,
	static function Off return LogLevel
)
instantiable final;
/
