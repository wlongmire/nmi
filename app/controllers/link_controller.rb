class LinkController < ApplicationController
	before_filter :authenticate_user!
	before_action :authenticate_user!

	def index
		#shows all or by user
		#also handles follow types
		user_name = (params.has_key? (:user_name)) ? params[:user_name] : current_user.username
		type = (params.has_key? (:type)) ? params[:type] : "posted"

		user = User.find_by({username: user_name})
		@links = Link.where({user:user})
	end

	def show
		#shows indivisual link page
		@link = Link.find(params[:id])
	end

	def destroy
		#shows indivisual link page
		Link.find(params[:id]).destroy
		
		redirect_to ({action: :index})
	end
end