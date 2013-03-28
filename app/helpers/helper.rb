def oauth
consumer=OAuth::Consumer.new( CONSUMER_KEY, CONSUMER_SECRET, {
      :site=>"https://api.twitter.com"
      })

  request_token = consumer.get_request_token({:oauth_callback => 'http://localhost:9292/authorized'})
  session[:request_token] = request_token
  redirect request_token.authorize_url
  
end

def authorize
  request_token = session[:request_token]
  access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])    
  user = User.find_or_create_by_twitter_id(access_token.params[:user_id])
  session[:user_id] = user.id
  user.update_attributes({:access_token => access_token.token,:secret_token => access_token.secret})
  session[:access_token] = access_token.token
  session[:access_token_secret] = access_token.secret
end

def job_is_complete(jid)
  waiting = Sidekiq::Queue.new
  working = Sidekiq::Workers.new
  return false if waiting.find { |job| job.jid == jid }
  return false if working.find { |worker, info| info["payload"]["jid"] == jid }
  true
end