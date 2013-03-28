class TweetWorker
  include Sidekiq::Worker

  def perform(user_id, tweet_id)
    user = User.find(user_id)
    tweet = user.tweets.find(tweet_id)

    client = Twitter::Client.new(
    :oauth_token => user.access_token,
    :oauth_token_secret => user.secret_token
    )
    puts tweet.inspect
    client.update(tweet.text)
  end
  



end
