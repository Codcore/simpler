require_relative 'config/environment'
require_relative 'lib/simpler/middleware/logger'

use Simpler::AppLogger
run Simpler.application
