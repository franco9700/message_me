class SessionsController < ApplicationController
	before_action :logged_in_redirect, only: [:new, :create]

	def new

	end

	def create
		user = User.find_by(username: params[:session][:username])
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "You have succesfully logged in"
			redirect_to chatroom_path
		else
			flash.now[:error] = "Invalid login information"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:warning] = "You have succesfully logged out"
		redirect_to root_path
	end

	private

	def logged_in_redirect
		if logged_in?
			flash[:warning] = "You are already logged in"
			redirect_to chatroom_path
		end
	end
end