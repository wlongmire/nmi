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

	def new
	end

	def create
		link = Link.create(params.require(:link).permit(:name, :url));
		link.user = current_user

		if link.save
			flash[:success] = "Successfully Created."
			redirect_to({action: :index})

		else
			flash[:alert] = link.errors.full_messages.join(", ")
			render :new
		end
	end

	def destroy
		#shows indivisual link page
		Link.find(params[:id]).destroy
		
		redirect_to ({action: :index})
	end
end