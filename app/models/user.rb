class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def role?(base_role)
    role == base_role.to_s
  end

  def favorited(post)
    self.favorites.where(post_id: post.id).first
  end

  def voted(post)
    self.votes.where(post_id: post.id).first
  end

  def self.top_rated
    self.select('users.*').  #Select all of users attributes
      select('COUNT(DISTINCT comments.id) AS comments_count').  #Count number of user's comments
      select('COUNT(DISTINCT posts.id) AS posts_count').  #Count number of user's posts
      select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank'). #add number of comments and posts together of this user
      joins(:posts). #ties the posts table to the users table via user_id
      joins(:comments). #ties the comments table to the users table via user_id
      group('users.id'). #Group such that each line is a unique user ID
      order('rank DESC') #Rank in descending order
  end
end

