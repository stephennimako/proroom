require 'sinatra/base'
require 'sinatra/reloader'
require 'sprockets'
require 'uglifier'
require 'sass'

class Proroom < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  # initialize new sprockets environment
  set :assets, Sprockets::Environment.new

  # append assets paths
  assets.append_path "assets"
  assets.append_path "assets/fonts"
  assets.append_path "assets/images"

  assets.context_class.class_eval do
    def asset_path(path, options = {})
      "/assets/#{path}"
    end
  end

  # compress assets
  assets.js_compressor  = :uglify
  assets.css_compressor = :scss

  # get assets
  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets", "")
    settings.assets.call(env)
  end


  get '/' do
    erb :index
  end
end