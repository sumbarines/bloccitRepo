class FavoriteMailer < ActionMailer::Base
  default from: "sumbev@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    headers["Message-ID"] = "<comments/#{@comment.id}@bev-bloccit.example>" 
    headers["In-Reply-To"] = "<post/#{@post.id}@bev-bloccit.example>" 
    headers["References"] = "<post/#{@post.id}@bev-bloccit.example>" 

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
