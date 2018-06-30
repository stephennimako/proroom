require 'sinatra/base'
require 'sinatra/reloader'
require 'active_support/core_ext/string'
require './results'
require './results_formatter'

class Calculator < Sinatra::Base
  helpers Sinatra::ResultsFormatter

  configure :development do
    register Sinatra::Reloader
  end

  use Rack::Auth::Basic, 'Authorised' do |username, password|
    username == 'admin' && password == 'admin'
  end

  get '/' do
    erb :calculator
  end

  post '/' do
    params.transform_keys!{ |key| key.underscore }
    params.transform_values!{ |value| value.to_f }
    results = Results.new(params)
    erb :results, locals: {results: results}
  end
end