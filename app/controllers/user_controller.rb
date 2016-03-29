class UserController < ApplicationController
	before_filter :authenticate_user!
	before_action :authenticate_user!
	
	def index
		@users = User.all
	end

	def show
		# defaults to current_user
		user_name = (params.has_key? (:user_name)) ? params[:user_name] : current_user.username
		@user = User.find_by({username: user_name})
	end

	def destroy
		User.find_by({username: params[:user_name]}).destroy
		redirect_to ({action: :index})
	end
end