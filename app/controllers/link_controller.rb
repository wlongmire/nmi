class LinkController < ApplicationController
	def index
		#shows all or by user
		#also handles follow types
		user = User.find_by({username: params[:user_name]})
		@links = Link.where({user:user})
	end

	def show
		#shows indivisual link page
		@link = Link.find(params[:id])

	end
end