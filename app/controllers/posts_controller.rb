class PostsController < ApplicationController
  def new
    @post = Post.new
    @topic = Topic.find(params[:topic_id])
    authorize @post
  end

# => no longer needed after Posts were associated with Topics
#  def index
#    @posts = Post.all
#    authorize @posts
#  end

  def show  
    @topic = Topic.find(params[:topic_id])
    authorize @topic
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    @comments = Comment.all
    #raise
    authorize @post
    if @post.save
      redirect_to [@topic, @post], notice: "Post was saved successfully."
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @comments = Comment.all
    authorize @post
  end
  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])

    title = @post.title
    authorize @post
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting \"#{title}\"."
      render :show
    end
  end

  
  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

end