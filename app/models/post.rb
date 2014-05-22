class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  scope :top_rated, -> { order("votes_count DESC") }
  mount_uploader :image, ImageUploader # add this line.
  
  default_scope { order('created_at DESC')}
  scope :visible_to, ->(user) { user ? all : joins(:topic).where('topics.public' => true)}

  validates :title, length: { minimum: 5}, presence: true
  validates :body, length: { minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  after_create :create_vote

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def total_score
    self.votes.sum(:value).to_i
    #up_votes - down_votes
  end

  def update_rank
    age = (self.created_at - Time.new(1970, 1, 1))/86400
    new_rank = total_score + age

    self.update_attribute(:rank, new_rank)
  end

#  def self.top_rated
#  self.select('posts.*').  #Select all of posts attributes
#    select('COUNT(DISTINCT votes) AS votes_count').  #Count number of post's votes
#    order('votes_count DESC') #Rank in descending order
#  end

  private

  def create_vote
    user.votes.create(value: 1, post: self)
  end
end

