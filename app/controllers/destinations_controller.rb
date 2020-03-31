class ExperiencesController < ApplicationController
  before '/experiences/*' do
    if !is_logged_in?
      flash[:login] = "You need to be logged in to performance that action"
      redirect to '/login'
    end
  end

  get '/experiences' do
    if is_logged_in?
      @user = current_user
      erb :"experiences/experiences"
    else
      flash[:login] = "You need to be logged in to performance that action"
      redirect to '/login'
    end
  end

  get '/experiences/users' do
    @user = current_user
    erb :"experiences/experiences_from_user"
  end

  get '/experiences/new' do
    @categories = Category.all
    erb :"experiences/create"
  end

  post '/experiences' do
    details = {
      :description => @params["description"],
      :country => @params["country"]
    }
    category_name = @params["category"]["name"]
    category_ids = @params["category"]["category_ids"]

    is_empty?(details, 'experiences/new')

    @experience = Experience.create_new_experience(details, category_name, category_ids, session[:user_id])

    flash[:success] = "Successfully created new experience!"
    redirect to "experiences/#{@experience.id}"
  end

  get '/experiences/:id/new_from_user' do
    user = current_user
    @experience = Experience.find(params["id"])
    if @experience.user_id == user.id
      flash[:add_from_user] = "This experience already belongs to you!"
      redirect to "/experiences/#{params["id"]}"
    else
      erb :"experiences/create_from_user"
    end
  end

  post '/experiences/new_from_user' do
    details = {
      :description => @params["description"],
      :country => @params["country"]
    }
    category_name = @params["category"]["name"]
    category_ids = @params["category"]["category_ids"]

    is_empty?(details, "experiences/#{params[:id]}/new_from_user")

    @experience = Experience.create_new_experience(details, category_name, category_ids, session[:user_id])

    flash[:success] = "Successfully created new experience!"
    redirect to "experiences/#{@experience.id}"
  end

  get '/experiences/:id/edit' do
    @user = current_user
    @experience = Experience.find(params["id"])
    if @user.id != @experience.user_id
      flash[:edit_user] = "You can only edit your own experiences"
      redirect to "/experiences/#{@experience.id}"
    end
    erb :"experiences/edit"
  end

  patch '/experiences/:id' do
    experience = Experience.find(params[:id])

    details = {
      :description => params["description"],
      :country => params["country"]
    }
    category_name = params["category"]["name"]
    category_ids = params["category"]["category_ids"]

    is_empty?(details, "experiences/#{params[:id]}/edit")

    exp = Experience.update_experience(details, category_name, category_ids, experience)

    flash[:success] = "Successfully updated your experience!"
    redirect to "experiences/#{exp.id}"
  end

  delete '/experiences/:id/delete' do
    @user = current_user
    @experience = Experience.find(params[:id])
    if @user.id != @experience.user_id
      flash[:edit_user]
      redirect to '/experiences/#{@experience.id}'
    else
      @experience.destroy
      flash[:deleted] = "Your experience has been deleted"
      redirect to '/experiences'
    end
  end

  get '/experiences/:id' do
    @user = current_user
    @experience = Experience.find(params["id"])
    erb :"experiences/show"
  end

end