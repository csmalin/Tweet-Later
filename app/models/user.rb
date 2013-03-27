class User < ActiveRecord::Base
  has_many :tweets

  def tweets_stale?
    @tweets = self.tweets
    Time.now - @tweets.last.created_at >= 900 if @tweets != []
  end  

  def fetch_tweets!
  p '*' * 20
    puts 'Fetching from the Twitter API!'
  p '*' * 20
    @tweets = Twitter.user_timeline(self.username)
    @tweets.each do |tweet|
      self.tweets.create(:text => tweet.text)
    end
  end
end