class Tweet < ActiveRecord::Base
  attr_accessible :source_id, :text, :twitter_user_id, :source_created_at
  validates :source_id, :uniqueness => { :scope => [:twitter_user_id] }
  
  belongs_to :twitter_user
end
