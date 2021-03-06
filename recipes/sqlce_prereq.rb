#
# Author:: Joe Fitzgerald
# Cookbook Name:: visualstudio
# Recipe:: sqlce_prereq
#
# Copyright 2013, Joe Fitzgerald.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# VS requires SQL CE 4.0 to be installed before installation to avoid a forced reboot
sqlce_file = File.join(
  'C:\\Program Files\\Microsoft SQL Server Compact Edition\\v4.0',
  'sqlcecompact40.dll')

if !File.exists?(sqlce_file)
  Chef::Log.warn 'SQL CE 4.0 is not installed, please install it and rerun chef'
end

# Let other recipes know it's missing at start of run
node.set['visualstudio']['sqlce_is_installed'] = File.exists?(sqlce_file)
