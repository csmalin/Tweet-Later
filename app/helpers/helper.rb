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

  session[:access_token] = access_token.token
  session[:access_token_secret] = access_token.secret
end

def tweet
  @client = Twitter::Client.new(
    :consumer_key => CONSUMER_KEY,
    :consumer_secret => CONSUMER_SECRET,
    :oauth_token => session[:access_token],
    :oauth_token_secret => session[:access_token_secret]
    )
  @client.update(params[:tweet])
  return ''
end