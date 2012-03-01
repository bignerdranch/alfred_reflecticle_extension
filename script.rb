require 'rubygems'
require 'bundler'
Bundler.require
require File.join(File.dirname(__FILE__), 'lib', 'reflecticle')

args = ARGV[0].split
project = args[0]
message = args.drop(1).join(' ')
api_key = Reflecticle.api_key

client = Reflecticle.new(api_key)
client.log(project, message)
