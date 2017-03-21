require "bundler/gem_tasks"
require "rspec/core/rake_task"
require_relative 'sync'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
namespace :template do
  desc 'Clone template repo from github then sync with generator'
  task :sync do
    sync_template
  end
end
