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
    @list = List.new(params_list)
    if @list.save
      redirect_to list_path(@list), notice: 'Restaurant created!'
    else
      render :new
    end
  end

  private

  def find_list
    @list = List.find(params[:id])
  end

  def params_list
    params.require(:list).permit(:name)
  end
end
