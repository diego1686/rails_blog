class PostsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]
  before_filter :correct_id, :only => [:edit, :update, :destroy]

  def show
    @post = Post.find_by_id(params[:id])
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "Post created!"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update_attributes(params[:post])
       flash[:success] = "Post updated!"
       redirect_to posts_path
    else
      render 'edit'
    end

  end

  def destroy
    post = Post.find_by_id(params[:id])
    post.destroy if post
    redirect_to posts_path
  end

  private

  def correct_id
    post = Post.find_by_id(params[:id])
    redirect_to posts_path if post.user != current_user
  end
end
