#
# Cookbook Name:: cookbook_hub
# Recipe:: default
#

adoptopenjdk_install '8'
include_recipe 'cookbook_hub::hub'
include_recipe 'cookbook_hub::service'
