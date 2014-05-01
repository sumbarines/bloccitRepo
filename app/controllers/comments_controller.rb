class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find( params[:post_id])
    @comments = @post.comments
    @comment.post = @post

    @comment = current_user.comments.build(comment_params)

    if @comment.save
      flash[:notice] = "Comment was created."
    else
      flash[:error] = "There was an error saving the comment."
    end

  end

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

end
