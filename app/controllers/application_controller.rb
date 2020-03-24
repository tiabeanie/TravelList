class ApplicationController < Sinatra::Base

    configure do 
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "lovetotravel"
    end 

    get '/' do 
        session[:greeting] = "Hello World"
        "Hello World"
    end

end