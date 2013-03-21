module SessionsHelper
	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def authenticate 
		if !current_user
			flash[:error] = "Please sign in to access this page."
			redirect_to root_path
		end
	end
end
