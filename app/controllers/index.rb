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

get '/status/:job_id' do
  job_is_complete(params[:job_id]).to_json
end

get '/:username' do
  @user = User.find_or_create_by_username(params[:username])
  erb :tweets
end

get '/:username/tweets' do
  @user = User.find_or_create_by_username(params[:username])

  if @user.tweets.empty? || @user.tweets_stale?
    @user.fetch_tweets!
  end

  @tweets = @user.tweets.limit(10)
  erb :_tweet_list, :layout => false
end

post '/' do  
  user = User.find(session[:user_id])
  job_id = user.tweet(params[:tweet])
  "/status/#{job_id}"
end


