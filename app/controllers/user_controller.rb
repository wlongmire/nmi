class UserController < ApplicationController
	before_filter :authenticate_user!
	before_action :authenticate_user!
	
	def index
		@users = User.all.order(:id)
	end

	def show
		# defaults to current_user
		user_name = (params.has_key? (:user_name)) ? params[:user_name] : current_user.username
		
		@user = User.find_by({username: user_name})
	end

	def edit
		# defaults to current_user
		user_name = (params.has_key? (:user_name)) ? params[:user_name] : current_user.username

		@user = User.find_by({username: user_name})
	end

	def follow
		puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		puts "#{current_user.username} is now following link #{params[:link_id]}"
		puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

		link = Link.find(params[:link_id])
		link.followers.push(current_user)

		redirect_to links_path("following")
	end

	def unfollow
		puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		puts "#{current_user.username} is not following link #{params[:link_id]}"
		puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

		link = Link.find(params[:link_id])
		link.followers.delete(current_user)

		redirect_to links_path("following")
	end

	def update
		user_params = params[:user]
		user = User.find(params[:id].to_i)

		if (user_params.has_key? (:admin))
			user[:admin] = (user_params[:admin] == "1")
		end

		if (user_params.has_key? (:username))
			user[:username] = user_params[:username]
		end

		if (user_params.has_key? (:email))
			user[:email] = user_params[:email]
		end

		if (user_params.has_key? (:password) and user_params[:password] != "")
			if (user_params[:password] == user_params[:password_confirmation])
				user[:encrypted_password] = User.new(password: user_params[:password]).encrypted_password
			else
				flash[:alert] = "Error password do not match."
				redirect_to(edit_user_path(User.find(params[:id].to_i).username))
				return
			end
		end
		
		if user.save
			flash[:success] = "Successfully Created."
			redirect_to({action: :index})
			
		else
			flash[:alert] = link.errors.full_messages.join(", ")
			redirect_to({action: :index})
		end
	end

	def destroy
		User.find_by({username: params[:user_name]}).destroy
		redirect_to ({action: :index})
	end
end