require_relative './config/environment'

use Rack::MethodOverride
use UsersController
use CountriesController
use DestinationsController
run ApplicationController
