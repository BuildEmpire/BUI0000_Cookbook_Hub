#
# Cookbook Name:: cookbook_hub
# Recipe:: default
#

include_recipe 'java::default'
include_recipe 'cookbook_hub::hub'
include_recipe 'cookbook_hub::service'
