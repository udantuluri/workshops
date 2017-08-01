#
# Cookbook:: tomcat
# Recipe:: default
#Instruction :https://www.vultr.com/docs/how-to-install-apache-tomcat-8-on-centos-7
# Copyright:: 2017, The Authors, All Rights Reserved.
package 'java-1.8.0-openjdk.x86_64'

group 'chef' do
  action :create
end

user 'chef' do
  group 'chef'
end

remote_file '/tmp/apache-tomcat-8.5.16.tar.gz' do
  source 'http://ftp.wayne.edu/apache/tomcat/tomcat-8/v8.5.16/bin/apache-tomcat-8.5.16.tar.gz'
  action :create
 end

directory '/opt/tomcat' do
  action :create
  recursive true
end

execute 'extract_tomcat' do
  command 'tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'
  cwd '/tmp'
end

execute 'chgrp -R chef /opt/tomcat/conf'

execute 'chmod g+rwx conf' do
  cwd '/opt/tomcat'
end

execute 'chmod g+r conf/*' do
  cwd '/opt/tomcat'
end

execute 'chown -R chef webapps/ work/ temp/ logs/ conf/' do
  cwd '/opt/tomcat'
end

execute 'chgrp -R chef bin' do
  cwd '/opt/tomcat'
end

execute 'chgrp -R chef lib' do
  cwd '/opt/tomcat'
end

execute 'chmod g+rwx bin' do
  cwd '/opt/tomcat'
end

execute 'chmod g+r bin/*' do
  cwd '/opt/tomcat'
end

file '/etc/systemd/system/tomcat.service' do
  content "# Systemd unit file for tomcat
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID

User=chef
Group=chef

[Install]
WantedBy=multi-user.target"
  action :create
end

execute 'systemctl daemon-reload'

service 'tomcat' do
  action [:start, :enable]
end
