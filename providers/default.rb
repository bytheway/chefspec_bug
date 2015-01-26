use_inline_resources

action :create do
  initialize_variables
end

def initialize_variables
  @vhost_name = new_resource.vhost_name
end


attr_reader :vhost_name
