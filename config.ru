require './proroom'
require './calculator'

run Rack::URLMap.new({
                         '/' => Proroom,
                         '/calculator' => Calculator
                     })