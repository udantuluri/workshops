#
# Cookbook:: remediation
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

file '/etc/login.defs' do
  content '#
# Password aging controls:
#
#   PASS_MAX_DAYS   Maximum number of days a password may be used.
#   PASS_MIN_DAYS   Minimum number of days allowed between password changes.
#   PASS_WARN_AGE   Number of days warning given before a password expires.
#
PASS_MAX_DAYS   90
PASS_MIN_DAYS   0
PASS_WARN_AGE   7'
  action :touch
end
