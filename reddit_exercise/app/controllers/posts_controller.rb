class PostsController < ApplicationController
  before_action :ensure_logged_in
  
  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = params[:author_id]

    if @post.save
      redirect_to sub_url(@post.sub.id)
    else 
      flash.now[:errors] = @post.errors.full_messages
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    render :edit
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post && @post.author == current_user && @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post && @post.author == current_user && @post.delete
      redirect_to subs_url
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to subs_url
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :author_id, sub_ids:[])
  end
end
