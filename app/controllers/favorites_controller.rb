class FavoritesController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)

    authorize favorite
    if favorite.save
      flash[:notice] = "Favorited post."
    else
      flash[:error] = "Unable to add Favorite."
    end
    redirect_to [@topic, @post]
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)

    authorize favorite
    if favorite.destroy
      flash[:notice] = "Unfavorited."
    else
      flash[:error] = "Unable to remove Favorite."
    end
    redirect_to [@topic, @post]
  end
end
