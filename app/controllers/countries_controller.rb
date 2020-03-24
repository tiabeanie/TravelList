class CountriesController < ApplicationController 

    get "/countries" do
      redirect_if_not_logged_in
      @country = Country.all
      erb :'countries/index'
    end
  
    get "/countries/new" do
      redirect_if_not_logged_in
      @error_message = params[:error]
      erb :'countries/new'
    end
  
    get "/countries/:id/edit" do
      redirect_if_not_logged_in
      @error_message = params[:error]
      @country = Country.find(params[:id])
      erb :'countries/edit'
    end
  
    post "/countries/:id" do
      redirect_if_not_logged_in
      @country = Country.find(params[:id])
      unless Country.valid_params?(params)
        redirect "/countries/#{@country.id}/edit?error=invalid country"
      end
      @country.update(params.select{|k|k=="name"})
      redirect "/countries/#{@country.id}"
    end
  
    get "/countries/:id" do
      redirect_if_not_logged_in
      @country = Country.find(params[:id])
      erb :'countries/show'
    end
  
    post "/countries" do
      redirect_if_not_logged_in
  
      unless Country.valid_params?(params)
        redirect "/countries/new?error=invalid country"
      end
      Country.create(params)
      redirect "/countries"
    end
  end