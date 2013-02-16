autoload :Finder,     "mapa76/core/lib/finder"
autoload :TimeSetter, "mapa76/core/lib/time_setter"

require "mongoid"
require "resque"

module Mongoid
  autoload :References, "mapa76/core/lib/mongoid/references"
end
