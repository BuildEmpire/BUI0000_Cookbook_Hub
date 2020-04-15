#
# Cookbook Name:: cookbook_hub
# Recipe:: service
#

# Decipher the locations
archive_directory = Chef::Config[:file_cache_path]
hub_version = node['cookbook_hub']['hub']['version']
install_root_dir = node['cookbook_hub']['hub']['install_root_dir']
data_directory = node['cookbook_hub']['hub']['data_dir']
backup_directory = node['cookbook_hub']['hub']['backup_dir']
memory_options = node['cookbook_hub']['hub']['memory_options']

# Calculate some variables
install_dir = "#{install_root_dir}/#{hub_version}"
shell_script_path = "#{install_dir}/bin/hub.sh"

if node['cookbook_hub']['systemd']
  systemd_unit "hub.service" do
    enabled true
    active true
    content "[Unit]\nDescription=Hub\nAfter=network.target\n\n[Service]\nType=forking\nPIDFile=" + install_dir + "/logs/hub.pid\nExecStart=" + shell_script_path + " start\nExecStop=" + shell_script_path + " stop\n\nRestart=always\n[Install]\nWantedBy=multi-user.target"
    action [:create, :enable, :start]
  end
else
  # Create hub Service
  template '/etc/init/hub.conf' do
    source 'hub.conf.erb'
    variables(
      :memory_options => memory_options,
      :shell_script_path => shell_script_path
    )
    notifies :start, 'service[hub]', :immediately
  end

  # Start hub Service
  service "hub" do
    provider Chef::Provider::Service::Upstart
    action :restart
  end
end
