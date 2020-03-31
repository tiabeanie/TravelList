class DestinationsController < ApplicationController
  before '/destinations/*' do
    if !is_logged_in?
      flash[:login] = "You need to be logged in to performance that action"
      redirect to '/login'
    end
  end

  get '/destinations' do
    if is_logged_in?
      @user = current_user
      erb :"destinations/destinations"
    else
      flash[:login] = "You need to be logged in to performance that action"
      redirect to '/login'
    end
  end

  get '/destinations/users' do
    @user = current_user
    erb :"destinations/destinations_from_user"
  end

  get '/destinations/new' do
    erb :"destinations/create"
  end

  post '/destinations' do
    details = {
      :description => @params["description"],
      :country => @params["country"]
    }

    is_empty?(details, 'destinations/new')

    @destination = Destination.create_new_destination(details, category_name, category_ids, session[:user_id])

    flash[:success] = "Successfully created new destination!"
    redirect to "destinations/#{@destination.id}"
  end

  get '/destinations/:id/new_from_user' do
    user = current_user
    @destination = destination.find(params["id"])
    if @destination.user_id == user.id
      flash[:add_from_user] = "This destination already belongs to you!"
      redirect to "/destinations/#{params["id"]}"
    else
      erb :"destinations/create_from_user"
    end
  end

  post '/destinations/new_from_user' do
    details = {
      :description => @params["description"],
      :country => @params["country"]
    }

    is_empty?(details, "destinations/#{params[:id]}/new_from_user")

    @destination = Destination.create_new_destination(details, session[:user_id])

    flash[:success] = "Successfully created new destination!"
    redirect to "destinations/#{@destination.id}"
  end

  get '/destinations/:id/edit' do
    @user = current_user
    @destination = Destination.find(params["id"])
    if @user.id != @destination.user_id
      flash[:edit_user] = "You can only edit your own destinations"
      redirect to "/destinations/#{@destination.id}"
    end
    erb :"destinations/edit"
  end

  patch '/destinations/:id' do
    destination = Destination.find(params[:id])

    details = {
      :description => params["description"],
      :country => params["country"]
    }

    is_empty?(details, "destinations/#{params[:id]}/edit")

    dest = Destination.update_destination(details, destination)

    flash[:success] = "Successfully updated your destination!"
    redirect to "destinations/#{dest.id}"
  end

  delete '/destinations/:id/delete' do
    @user = current_user
    @destination = Destination.find(params[:id])
    if @user.id != @destination.user_id
      flash[:edit_user]
      redirect to '/destinations/#{@destination.id}'
    else
      @destination.destroy
      flash[:deleted] = "Your destination has been deleted"
      redirect to '/destinations'
    end
  end

  get '/destinations/:id' do
    @user = current_user
    @destination = Destination.find(params["id"])
    erb :"destinations/show"
  end

end