require 'open-uri'

class ListsController < ApplicationController
  before_action :find_list, only: %i[show]

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

  # Dans params de list create if photo = nil then attach url

  private

  def find_list
    @list = List.find(params[:id])
  end

  def params_list
    params.require(:list).permit(:name, :photo)
  end
end
