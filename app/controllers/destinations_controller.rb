class DestinationsController < ApplicationController 
    get "/destinations" do
      redirect_if_not_logged_in 
      @destination = Destination.all
      erb :'destinations/index'
    end
  
    get "/destinations/new" do
      redirect_if_not_logged_in 
      @error_message = params[:error]
      erb :'destinations/new'
    end
  
    get "/destinations/:id/edit" do
      redirect_if_not_logged_in 
      @error_message = params[:error]
      @destination = Destination.find(params[:id])
      erb :'destinations/edit'
    end
  
    post "/destinations/:id" do
      redirect_if_not_logged_in 
      @destination = Destination.find(params[:id])
      unless Destination.valid_params?(params)
        redirect "/destinations/#{@destination.id}/edit?error=invalid destination"
      end
      @destination.update(params.select{|k|k=="name" || k=="country_id"})
      redirect "/destinations/#{@destination.id}"
    end
  
    get "/destinations/:id" do
      redirect_if_not_logged_in 
      @destination = Destination.find(params[:id])
      erb :'destinations/show'
    end
  
    post "/destinations" do
      redirect_if_not_logged_in 
      unless Destination.valid_params?(params)
        redirect "/destinations/new?error=invalid destination"
      end
      Destination.create(params)
      redirect "/destinations"
    end
  end