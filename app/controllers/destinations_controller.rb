class DestinationsController < ApplicationController

    get '/destinations' do
        "Welcome, #{session[:email]}!"
    end

end 