class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_name] = user.name

      if user.name.eql? "gringo" or user.name.eql? "andresz" or user.name.eql? "reconshot"
        redirect_to admin_index_url
      else
        redirect_to store_url, notice: "Welcome #{user.name.capitalize}"
      end

    else
      redirect_to login_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "Logged out"
  end

end
