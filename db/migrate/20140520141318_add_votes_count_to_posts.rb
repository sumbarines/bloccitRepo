class AddVotesCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :votes_count, :integer, default: 0
    
    Post.find_each(select: 'id') do |result|
      Post.reset_counters(result.id, :votes)
    end
  end
end
