class GifsController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :set_scope, only: [:index]

  def index
    @gifs = @scope.by_score.page(params[:page])
  end

  def show
    @gif = Gif.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @gif = Gif.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @gif = Gif.new(gif_params)
    @gif.user = current_user
    if @gif.save
      respond_to do |format|
        format.html {
          flash[:success] = "A new gif terrorizes the internet"
          redirect_to :root
        }
        format.js { }
      end
    else
      flash[:danger] = "Invalid, try again"
      render :new
    end
  end

  def destroy
    gif = Gif.find(params[:id])
    gif.destroy if gif.user == current_user
    respond_to do |format|
      format.html {
        flash[:success] = "Gif successfully deleted"
        redirect_to :root
      }
      format.js { }
    end
  end

  private

  def gif_params
    params.require(:gif).permit(:url, :description, :tag_list, :gif_image)
  end

  def set_scope
    if params[:tag]
      @scope = Gif.tagged_with("#" + params[:tag])
    else
      @scope = Gif
    end
    @scope
  end

end
