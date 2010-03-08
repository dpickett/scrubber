$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'scrubber'
require 'spec'
require 'spec/autorun'

require 'models'

Spec::Runner.configure do |config|
  
end
