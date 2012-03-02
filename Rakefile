require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'
require 'fileutils'

RSpec::Core::RakeTask.new(:spec)

task :default => [:spec]

task :install do
  EXTENSION_PATH = File.expand_path(File.join('~', 'Library', 'Application Support', 'Alfred', 'extensions', 'scripts', 'Reflecticle'))
  puts "Installing"
  FileUtils.rm_rf(EXTENSION_PATH)
  FileUtils.mkdir_p(EXTENSION_PATH)
  FileUtils.cp_r('.', EXTENSION_PATH)
  puts "Done!"
end
