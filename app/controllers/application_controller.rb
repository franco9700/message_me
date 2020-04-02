class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in?, :require_user #permite acceso a los metodos desde las vistas

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id] #optimizado para no pedir el usuario cada vez
		#||= -> if not
	end

	def logged_in?
		!!current_user #regresa verdadero si hay un current user
	end

	def require_user
		if !logged_in?
			flash[:error] = "You must be logged in to perform that action"
			redirect_to login_path
		end
	end
end
