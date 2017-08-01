#
# Cookbook:: mongodb
# Recipe:: default
# About:: mongodb on Redhat/CentOS
# Instructions:: https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/
# Instructions2:: https://raw.githubusercontent.com/udantuluri/workshops/master/Install_MongoDB/install.rb
# Copyright:: 2017, The Authors, All Rights Reserved.

file '/etc/yum.repos.d/mongodb-org-3.4.repo' do
  content '[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc'
  action :create
end

package 'mongodb-org'

service 'mongod' do
  action [:start, :enable]
end
