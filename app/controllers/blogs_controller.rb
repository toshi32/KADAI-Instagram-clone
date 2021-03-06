class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  # before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new(content: params[:content],user_id: @current_user.id)
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.id = params[:id]
    @blog.user_id = current_user.id
    if @blog.save
      ContactMailer.contact_mail(@blog).deliver  ##追記
      redirect_to blogs_path, notice: "Yeah！！ブログを作成したYO！！"
    else
      render :new
    end
  end

  def show
    @blog = Blog.find_by(id: params[:id])
    @user = User.find_by(id: @blog.user_id)
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
  end

  def update
    @blog.remove_image!
    @blog.save
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "Hey！！ブログを編集したYO！！"
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"Uh-oh.ブログを削除したYO！！"
  end

  def confirm
    @blog = Blog.new(blog_params)
    @blog.id = params[:id]
    @blog.user_id = current_user.id
    if @blog.user_id?
      render :edit and return if @blog.invalid?
    else
      render :new if @blog.invalid?
    end
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache, :remove_image)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  # def ensure_correct_user
  #   @blog = Blog.find(params[:id])
  #   if @blog.user_id != current_user.id
  #     flash[:notice] = "No authority"
  #     redirect_to blogs_url
  #   end
  # end

end