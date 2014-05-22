class PostsController < ApplicationController
  def index
    #@posts = Post.visible_to(current_user).where("posts.created_at > ?",7.days.ago).paginate(page: params[:page], per_page: 10)
    #@posts = Post.visible_to(current_user).top_rated.paginate(page: params[:page], per_page: 10)
    @posts = Post.visible_to(current_user).top_rated.limit(5)
  end
end

  