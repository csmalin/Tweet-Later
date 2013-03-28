class User < ActiveRecord::Base
  has_many :tweets

  def tweet(status)
    TweetWorker.perform_async(self.id, self.tweets.create(:text => status).id)
  end

  def tweets_stale?
    @tweets = self.tweets
    Time.now - @tweets.last.created_at >= 900 if @tweets != []
  end  

  def fetch_tweets!
    @tweets = Twitter.user_timeline(self.username)
    
    @tweets.each do |tweet|
      self.tweets.create(:text => tweet.text)
    end
  end
end