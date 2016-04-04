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
		link.name = link.name[0, 50] if link.name.length > 50
		link.user = current_user

		if params[:link][:folders].length <= 1
			flash[:alert] = "Error: Must add at least one folder."
			render :new
			return
		end

		#collect folders
		params[:link][:folders][1, params[:link][:folders].length-1].each do |f|
			if (f != "") 
				link.folders.push(Folder.find(f.to_i))
			end
		end

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