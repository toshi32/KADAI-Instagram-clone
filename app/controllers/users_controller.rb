class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update]
  skip_before_action :login_required, only: [:new, :create]

  def index
    @user = User.all
  end

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
  end

  def edit
  end

  def update
    @user.remove_image!
    @user.save
    if @user.update(user_params)
      redirect_to user_path, notice: "Hey！！プロフィールを編集したYO！！"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache, :remove_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end