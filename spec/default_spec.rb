require 'chefspec'
require 'pry'


describe 'chefspec_bug lwrp pre-tet' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: ['chefspec_bug']).converge('chefspec_bug::_test')
  end

  before do
    chef_run
  end

  it 'has an empty test' do
    expect(true).to be_truthy
  end
end

describe 'chefspec_bug lwrp test' do
  let(:chef) do
    ChefSpec::SoloRunner.new(step_into: ['chefspec_bug']) do |node|
      node.automatic[:fqdn] = 'example.co.ihc.com'
      node.automatic[:hostname] = 'example'
    end
  end
  let(:chef_run) { chef.converge('chefspec_bug::_test') }
  let(:resource) { chef_run.find_resource('chefspec_bug', 'resource') }
  let(:provider) { Chef::Provider::ChefspecBug.new(resource, chef_run.run_context) }

  before do
    chef_run
  end

  it 'defines vhost_name as a String' do
    expect(provider.vhost_name).to be_nil
    provider.initialize_variables
    expect(provider.vhost_name.class).to eq String
    expect(provider.vhost_name).to eq 'example.co.ihc.com'
  end
end
