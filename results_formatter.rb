require 'sinatra/base'

module Sinatra
  module ResultsFormatter
    def format_price(price)
      sprintf('%.2f', price)
    end

    def display_result?(price)
      price > 0.0
    end
  end

  helpers ResultsFormatter
end