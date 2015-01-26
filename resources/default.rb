actions [:create]
default_action :create

attribute :vhost_name,  kind_of: String, default: lazy { node[:fqdn] }
