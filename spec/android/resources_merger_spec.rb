require 'spec_helper'
require_relative '../../lib/android/boilerplate/generator'
require_relative '../../lib/android/boilerplate/resources_merger'
describe AndroidBoilerplate::DependenciesMerger do

  def input_file
    @input_file = File.read(File.join(File.dirname(__FILE__), 'input', 'resources.xml'))
  end

  def output_file
    @output_file = File.read(File.join(File.dirname(__FILE__), 'output', 'resources.xml'))
  end

  def dependencies_merger
    op = Hash.new
    op[:input_file] = input_file
    op[:output_file] = output_file
    @dependencies_merger = AndroidBoilerplate::ResourcesMerger.new(op, 'string')
  end

  it 'should return true if resource already exist' do
    expect(dependencies_merger.exist_in_target?('<string name="app_name">App Name</string>', output_file)).to eq(true)
  end

  it "should return false if resource doesn't exist" do
    expect(dependencies_merger.exist_in_target?('<string name="login_activity_title">Login</string>', output_file)).to eq(false)
  end

  it 'should extract resource name correctly' do
    expect(dependencies_merger.extract_name('<string name="login_activity_title">Login</string>')[0]).to eq('login_activity_title')
  end

end