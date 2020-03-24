require_relative './config/environment'

require './config/environment'

use Rack::MethodOverride
use SessionsController
use UsersController
use CountriesController
use DestinationsController
run ApplicationController
