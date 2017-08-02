#
# Cookbook:: mongodb
# Recipe:: default
# About:: mongodb on Redhat/CentOS
# Instructions:: https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/
# Instructions2:: https://raw.githubusercontent.com/udantuluri/workshops/master/Install_MongoDB/install.rb
# Copyright:: 2017, The Authors, All Rights Reserved.

template '/etc/yum.repos.d/mongodb-org-3.4.repo' do
  source 'mongodb-org-3.4.repo.erb'
  action :create
end

package 'mongodb-org'

service 'mongod' do
  action [:start, :enable]
end
