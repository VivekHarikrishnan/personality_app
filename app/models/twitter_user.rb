class TwitterUser < ActiveRecord::Base
  attr_accessible :full_name, :screen_name
  @@twitter_configuration = nil

  INPUT_TYPES = { "Screen Name" => "screen_name", "User ID" => "user_id" }
  has_many :tweets, :dependent => :destroy
  validates :screen_name, :uniqueness => { :scope => [:source_id] }, :presence => true
  validates :source_id, :presence => true

  def self.configure
    @@twitter_configuration = Twitter.configure do |config|
      config.consumer_key = "Y8E6MLP63mzduaF0KLx4w"
      config.consumer_secret = "pd0ZXdxiuE9Rj8oiq5SfZRKoadvU20OmKuyhBDUF51o"
      config.oauth_token = "197386585-5JV7zwt3cFnL1u9qw0kICyWKRdrpWn3JF5IiChI3"
      config.oauth_token_secret = "Fn9dFTDnUgvAVVFeEL1cXDscyP3BX268OMv7h8ATMkc"
    end
  end

  def collect_tweets

  end

  def self.configuration
    @@twitter_configuration
  end
end