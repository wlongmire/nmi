class UserController < ApplicationController
	def index
		@users = User.all
	end

	def show
		puts params[:user_name]

		@user = User.find_by({username: params[:user_name]})
	end

	def destroy
		User.find_by({username: params[:user_name]}).destroy
		redirect_to ({action: :index})
	end
end