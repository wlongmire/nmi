class LinkController < ApplicationController
	include MyUtils

	before_filter :authenticate_user!
	before_action :authenticate_user!

	def index
		#shows all or by user
		#also handles follow types
		user_name = (params.has_key? (:user_name)) ? params[:user_name] : current_user.username
		@type = (params.has_key? (:type)) ? params[:type] : :all

		case @type
			when "posted"
				user = User.find_by({username: user_name})
				@links = Link.where({user:user})
			when "followed"
				user = User.find_by({username: user_name})
				@links = user.followees
			else
				@links = Link.all
		end

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
			# page = MetaInspector.new(url)

			# @link = Link.new({url:url, name:page.best_title, desc:page.description, img:page.images.best, favicon:page.images.favicon})
			@link = Link.new({url:url, name:"thig", desc:"", img:nil, favicon:nil})
			render :urlGenerated
		end
	end

	def create
		link = Link.create(params.require(:link).permit(:name, :url, :desc, :img, :favicon, :region_id));
		link.user = current_user

		#collect folders
		folders_models = collect_folders params[:link][:folders]
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
		link.desc = params[:link][:desc]
		link.region_id = params[:link][:region_id]

		link.folders = []
		#collect folders
		folders_models = collect_folders params[:link][:folders]
		folders_models.each { |f| link.folders.push(f) }

		link.followers = []
	
		#collect folders
		followers_models = collect_followers params[:link][:followers]

		followers_models.each { |f| link.followers.push(f) }

	  if link.save
	    flash[:success] = "Successfully Created."
			redirect_to(link_path(link.id))
	    else
	    	render :edit
	    end
		  
 	end
  

  	def search
  		@results = Link.all

  		debugLog params
  		
  		@results = @results.where('lower(name) ILIKE :search OR lower(url) ILIKE :search', search:"%#{params[:text].downcase}%") if !params[:text].nil? and !(params[:text] == "")
  		@results = @results.where({region_id: params[:region_id]}) if !params[:region_id].nil? and !(params[:region_id] == "")
  		@results = @results.joins(:folders).where('folder_id = ?', params[:folder_id]) if !params[:folder_id].nil? and !(params[:folder_id] == "")

  	end

	def destroy
		#shows indivisual link page
		Link.find(params[:id]).destroy
		
		redirect_to ({action: :index})
	end

	private

	def collect_folders f_list
		
		folders_models = []

		f_list[1, f_list.length-1].each do |f|
			if (f != "") 
				folders_models.push(Folder.find(f.to_i))
			end
		end

		folders_models
	end

	def collect_followers f_list
		
		follower_models = []

		f_list[1, f_list.length-1].each do |f|
			if (f != "") 
				follower_models.push(User.find(f.to_i))
			end
		end

		follower_models
	end

end