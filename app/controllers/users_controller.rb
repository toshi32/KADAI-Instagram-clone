class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @blog = Blog.find_by(id: @user.blog_id)
  end

  def edit
  end

  def update
    @user.remove_image!
    @user.save
    if @user.update(user_params)
      redirect_to users_path, notice: "Hey！！プロフィールを編集したYO！！"
    else
      render :edit
    end
  end

  def confirm
    @user = User.find(params[:id])
      unless @user.valid?
      render :edit
      return
      else
        redirect_to :update
      end
    #@user = User.new(user_params)
    #@user = User.find(params[:id])
    #@user.id = params[:id]
    #@user.blog_id = current_blog.id
    # if @user.id?
    #   render :edit and return if @user.invalid?
    # else
    #   render :new if @user.invalid?
    # end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache, :remove_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end