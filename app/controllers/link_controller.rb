class LinkController < ApplicationController
	include MyUtils

	before_filter :authenticate_user!
	before_action :authenticate_user!

	def index
		#shows all or by user
		#also handles follow types
		type = params[:type] || :all
		value = params[:value]
				
		case type
			when "category"
				@links = Link.joins(:folders).where(folders:{title: value}).order(created_at: :desc)
				@active = value
			
			when "region"
				@links = Link.order(created_at: :desc).joins(:region).where(regions:{name:value}).order(created_at: :desc)
				@active = "all"

			when "user"

				username = params[:name]
				user = User.find_by({username: username})

				@links = (value == "shared")? user.followees.order(created_at: :desc) : user.links.order(created_at: :desc)
				@active = "all"	

			else
				@links = Link.all.order(created_at: :desc)
				@active = "all"
		end

		@links.each do |l|
			puts l.created_at
		end

		render :index

	end

	def search

		debugLog params
		value = params[:q]
		
		@links = Link.all
		@links = @links.where('lower(name) ILIKE :search OR lower(url) ILIKE :search OR lower(description) ILIKE :search', search:"%#{value}%") if !value.nil? and !(value == "")

		@active = "all"

		render :index
	end


	def show
		#shows indivisual link page
		@link = Link.find(params[:id])
	end

	def new
	end

	def generate
		url = params[:link][:url]

		if url.nil?
			flash[:alert] = "Error: Must add a url."
			redirect_to new_link_path
		else
			page = MetaInspector.new(url)

			# @link = Link.new({url:url, name:page.best_title, description:page.description, img:page.images.best, favicon:page.images.favicon})
			@link = Link.new({url:url, name:page.best_title, description:page.description, img:page.images.best, favicon:page.images.favicon})
			render :urlGenerated
		end
	end

	def create
		link = Link.create(params.require(:link).permit(:name, :url, :description, :img, :favicon, :region_id));
		link.user = current_user

		#collect folders
		folders_models = collect_folders [params[:link][:folders]]
		folders_models.each { |f| link.folders.push(f) }

		#collect folders
		followers_models = collect_followers params[:link][:followers]
		followers_models.each { |f| link.followers.push(f) if f != current_user }
		
		if link.save
			flash[:success] = "Successfully Created."
			redirect_to(link_path(link.id))
		else
			flash[:alert] = link.errors.full_messages.join(", ")
			render :urlGenerated
		end
	end

	# GET
  def edit
  	@link = Link.find(params[:id])
  end
  
  # PATCH/PUT /folders/1
  def update
		link = Link.find(params[:id])
		link.name = params[:link][:name]
		link.url = params[:link][:url]
		link.description = params[:link][:description]
		link.region_id = params[:link][:region_id]

		link.folders = []
		#collect folders
		folders_models = collect_folders [params[:link][:folders]]
		folders_models.each { |f| link.folders.push(f) }

		link.followers = []

		#collect folders
		followers_models = collect_followers params[:link][:followers]

		followers_models.each { |f| link.followers.push(f) }

	  if link.save
	    flash[:success] = "Successfully Updated."
			redirect_to(link_path(link.id))
	   else
	   	debugLog(link.errors.full_messages);

	   	flash[:alert] = link.errors.full_messages.join(", ")
	   	@link = link
    	render :edit
	   end
		  
 	end
  	
	def add_share

	end

	def remove_share

	end

	def destroy
		#shows indivisual link page
		Link.find(params[:id]).destroy
		
		redirect_to ({action: :index})
	end

	private

	def collect_folders f_list
		
		folders_models = []

		f_list.each do |f|
			if (f != "") 
				folders_models.push(Folder.find(f.to_i))
			end
		end

		folders_models
	end

	def collect_followers f_list
		
		follower_models = []

		f_list.each do |f|
			if (f != "") 
				follower_models.push(User.find(f.to_i))
			end
		end

		follower_models
	end

end