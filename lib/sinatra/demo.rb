require_relative "demo/version"

module Sinatra
  module Demo
    class Error < StandardError; end
    # Your code goes here...
  end
end

require 'sinatra'
require 'sinatra/reloader' if development?

# 1. basic string
get '/' do
  'Hello Sinatra!'
end

# 2. named string
get '/params/:par_name?' do #'?' means a option param
  "Param name is #{params['par_name']}"
end

# 3. * string
get '/splat/*/*' do
  "Splat here #{params['splat']}"
end

# 4. regexp
get /\/regexp\/([\w]+)/ do
  "Captures here #{params['captures']}"
end

# 5. condMatch
set(:condition_name) do |*cond_params|
  condition do
    cond_params.length > 3
  end
end
get '/condition/', :condition_name => [:user, :admin] do
  "You are allowed here"
end

# 6. custom Match

# 7. access request
get '/env' do
  t = %w[text/css text/html application/javascript]
  request.accept              # ['text/html', '*/*']
  request.accept? 'text/xml'  # true
  request.preferred_type(t)   # 'text/html'
  request.body                # request body sent by the client (see below)
  request.scheme              # "http"
  request.script_name         # "/example"
  request.path_info           # "/foo"
  request.port                # 80
  request.request_method      # "GET"
  request.query_string        # ""
  request.content_length      # length of request.body
  request.media_type          # media type of request.body
  request.host                # "example.com"
  request.get?                # true (similar methods for other verbs)
  request.form_data?          # false
  request["some_param"]       # value of some_param parameter. [] is a shortcut to the params hash.
  request.referrer            # the referrer of the client or '/'
  request.user_agent          # user agent (used by :agent condition)
  request.cookies             # hash of browser cookies
  request.xhr?                # is this an ajax request?
  request.url                 # "http://example.com/example/foo"
  request.path                # "/example/foo"
  request.ip                  # client IP address
  request.secure?             # false (would be true over ssl)
  request.forwarded?          # true (if running behind a reverse proxy)
  request.env                 # raw env hash handed in by Rack
end

# 8. filter
before '/protected/*' do
  authenticate!
end

after '/create/:slug' do |slug|
  session[:last_slug] = slug
end
# 9. template and layout **
root_path = File.dirname(__FILE__)
set :views, "#{root_path}/views"
set :logging, true
get '/template/*/*' do |tmpl_type, tmpl_name|
  logger.info("template type is '#{tmpl_type}', template name is '#{tmpl_name}'")
  case tmpl_type
  when 'erb' #like ruby
    erb tmpl_name.to_sym, :locals => {:template_context => tmpl_name}
  when 'haml' #like html
    haml tmpl_name.to_sym, :format => :html5, :locals => {:template_context => tmpl_name}
  when 'sass' #like css
    sass tmpl_name.to_sym, :locals => {:template_context => tmpl_name}
  when 'scss' #like css
    scss tmpl_name.to_sym, :locals => {:template_context => tmpl_name}
  when 'rdoc' #document
    rdoc tmpl_name.to_sym, :locals => {:template_context => tmpl_name}
  when 'markdown' #document
    markdown tmpl_name.to_sym, :locals => {:template_context => tmpl_name}
  when 'coffee' #like javascript
    coffee tmpl_name.to_sym, :locals => {:template_context => tmpl_name}
  else
    logger.info("Unknown template type '#{tmpl_type}'")
  end
end

# 10. cache-control
# 11. stream and sendfile *
# 12. session
# 13. configuration **
configure do
  set :foo, 'bar'
  set :default_encoding, "utf-8"
end

post '/' do
  'create'
end

put '/' do
  'replace'
end

patch '/' do
  'modify'
end

delete '/' do
  'delete'
end

options '/' do
  'appease'
end

link '/' do
  'affiliate'
end

unlink '/' do
  'separate'
end
