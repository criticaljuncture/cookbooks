#
# Cookbook Name:: apache2
# Definition:: web_app
#
# Copyright 2008, OpsCode, Inc.
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



define :web_app, :docroot => nil, :canonical_hostname => false, :template => "web_app.conf.erb", :app_type => nil, :variables => nil do
  
  application_name = params[:name]

  include_recipe "apache2"
  include_recipe "apache2::mod_rewrite"
  include_recipe "apache2::mod_deflate"
  include_recipe "apache2::mod_headers"
  
  template "#{node[:apache][:dir]}/sites-available/#{application_name}" do
    source :template
    owner "root"
    group "root"
    mode 0644
    variables :variables
    notifies :reload, resources(:service => "apache2"), :delayed
  end
  
  apache_site "#{params[:name]}.conf"

end
