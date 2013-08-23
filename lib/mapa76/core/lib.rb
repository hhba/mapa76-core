autoload :Finder, "mapa76/core/lib/finder"
autoload :DocumentExporter, "mapa76/core/lib/document_exporter"
autoload :TimeSetter, "mapa76/core/lib/time_setter"
autoload :DocumentProcessBootstrapTask, "mapa76/core/lib/document_process_bootstrap_task"

require "mongoid"
require "resque"

module Mongoid
  autoload :References, "mapa76/core/lib/mongoid/references"
end
