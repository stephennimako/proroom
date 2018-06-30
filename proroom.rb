require 'sinatra/base'
require 'sinatra/reloader'
require 'sprockets'
require 'uglifier'
require 'sass'
require 'pony'

class Proroom < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  set :assets, Sprockets::Environment.new

  assets.append_path 'assets'
  assets.append_path 'assets/fonts'
  assets.append_path 'assets/images'

  assets.context_class.class_eval do
    def asset_path(path, options = {})
      "/assets/#{path}"
    end
  end

  assets.js_compressor = :uglify
  assets.css_compressor = :scss

  get '/assets/*' do
    env['PATH_INFO'].sub!('/assets', '')
    settings.assets.call(env)
  end

  get '/' do
    erb :index
  end

  post '/contact' do
    send_email params
  end

  def send_email params
    Pony.mail({
                  to: 'stephen.nimako@hotmail.co.uk',
                  from: 'stephen.nimako@hotmail.co.uk',
                  subject: 'New client from Pro Room contact form',
                  body: erb(:'email.text', locals: params),
                  html_body: erb(:'email.html', locals: params),
                  via: :smtp,
                  via_options: {
                      address: 'email-smtp.us-west-2.amazonaws.com',
                      port: '25',
                      user_name: 'AKIAI5MUBHXOCGGOUUBQ',
                      password: 'Au6f3FEfqYk+9Ask0hGQzgvQ+m0vmPu7qHhOy6S4xDNp',
                      authentication: :plain,
                      domain: 'localhost.localdomain'
                  }
              })
  end
end