require 'rubygems'
require 'bundler'
Bundler.require
require File.join(File.dirname(__FILE__), 'lib', 'reflecticle')

api_key = Reflecticle.api_key
client = Reflecticle.new(api_key)
client.log(ARGV[0])
