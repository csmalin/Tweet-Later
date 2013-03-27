get '/oauth' do
  oauth
end

get '/authorized' do
  authorize
  redirect '/'
end

get '/' do
  erb :index
end

get '/:username' do
  @user = User.find_or_create_by_username(params[:username])
  erb :tweets
end

get '/:username/tweets' do
  p '*' * 20
  p 'You made it!'
  p '*' * 20
  @user = User.find_or_create_by_username(params[:username])

  if @user.tweets.empty? || @user.tweets_stale?
    @user.fetch_tweets!
  end

  @tweets = @user.tweets.limit(10)
  erb :_tweet_list, :layout => false
end

post '/' do  
  tweet
end


