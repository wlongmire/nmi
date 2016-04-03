class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  # Get
  def index
    @folders = Folder.all
  end

  # GET
  def show
  end

  # GET
  def new
    @folder = Folder.new
  end

  # GET
  def edit
  end

  # POST
  def create
    @folder = Folder.new(folder_params)

    if @folder.save
      redirect_to @folder, notice: 'Folder was successfully created.'
    else
      render :new
    end
  
  end

  # PATCH/PUT /folders/1
  def update
    
    if @folder.update(folder_params)
      redirect_to @folder, notice: 'Folder was successfully updated.'
    else
      render :edit
    end
  
  end

  # DELETE
  def destroy
    @folder.destroy
    
      redirect_to folders_url, notice: 'Folder was successfully destroyed.'
  end

  def remove_link
    folder = Folder.find(params[:folder_id])
    link = Link.find(params[:link_id])

    if (link)
      folder.links.delete(link)
    end

    redirect_to folders_url()
    
  end

  private
    def set_folder
      @folder = Folder.find(params[:id])
    end

    def folder_params
      params.require(:folder).permit(:title, :desc)
    end
end
