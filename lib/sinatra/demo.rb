#require "sinatra/demo/version"

module Sinatra
  module Demo
    class Error < StandardError; end
    # Your code goes here...
  end
end

require 'sinatra'
get '/' do
  'Hello Sinatra!'
end
