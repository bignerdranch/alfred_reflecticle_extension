require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), 'lib', 'reflecticle')

api_key = Reflecticle.api_key
client = Reflecticle.new(api_key)
client.log(ARGV[0])
