require 'open-uri'

class ListsController < ApplicationController
  before_action :find_list, only: %i[show destroy]
  protect_from_forgery except: :destroy

  def index
    @lists = List.all
  end

  def show
    # @bookmark = @bookmark.list(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    if params_list[:photo].nil?
      file = URI.open("https://picsum.photos/seed/picsum/200/300")
      @list = List.new(name: params_list[:name])
      @list.photo.attach(io: file, filename: 'placeholder.jpg', content_type: 'image/jpg')
    else
      @list = List.new(params_list)
    end
    if @list.save
      redirect_to list_path(@list), notice: 'Restaurant created!'
    else
      render :new
    end
  end

  def destroy
    respond_to do |format|
      format.html do
        @list.destroy
        redirect_to lists_path
        end

      format.json do
        @list.destroy
        end
      end
  end

  private

  def find_list
    @list = List.find(params[:id])
  end

  def params_list
    params.require(:list).permit(:name, :photo)
  end
end
