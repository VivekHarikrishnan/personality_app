class TweetsController < ApplicationController
  def index
    @twitter_user = TwitterUser.new
    @input_types = TwitterUser::INPUT_TYPES
  end

  def collect
    configuration = TwitterUser.configure
    if params[:input_type] == "user_id"
      @tweet_user = TwitterUser.find_by_source_id(params[:id].to_i)
      if @tweet_user.blank?
        user_info = configuration.user(params[:id].to_i)
        @tweet_user = TwitterUser.create(:source_id => user_info.id, :screen_name => user_info.screen_name,
          :full_name => user_info.name)
      end
      collected_tweets = configuration.user_timeline(params[:id].to_i)
    elsif params[:input_type] == "screen_name"
      @tweet_user = TwitterUser.find_by_screen_name(params[:id])

      if @tweet_user.blank?
        user_info = configuration.user(params[:id])
        @tweet_user = TwitterUser.create(:source_id => user_info.id.to_i, :screen_name => user_info.screen_name,
          :full_name => user_info.name)
      end

      collected_tweets = configuration.user_timeline(params[:id])
    end

    collected_tweets.each do |collected_tweet|
      tweet = Tweet.find_or_create_by_source_id_and_twitter_user_id(collected_tweet.id.to_i, @tweet_user.id)
      tweet.text = collected_tweet.text
      tweet.source_id = collected_tweet.id
      tweet.source_created_at = collected_tweet.created_at
      tweet.save!
    end

    @tweets = @tweet_user.tweets
  end
end
