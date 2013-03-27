$(document).ready(function(){
  var pass = true ;
    
  function IsTweet(tweet) {
    if (tweet.val().length > 140) {
     $('#errors').append("<li>You have fucked up!</li>");
      pass = false
    };
  };

  $('#tweet_form').submit(function(e) {
    e.preventDefault();
    pass = true;
    $('ul#errors').empty();
    IsTweet($("#tweet"));

    if (pass == true) {
      $('#tweet_form input').attr({'disabled':'true'});
      $('#errors').append("<li>We're processing your tweet, sire.</li>");

      $.ajax({
        method: 'POST',
        data: {tweet: $('#tweet').val()},
        url: '/'
      }).done (function(data){
        debugger
        console.log("This shit worked!!!");
        $('#errors').append("<li>It worked! You're amazing!</li>");
      }).fail (function(jqXHR, textStatus, errorThrown){
        debugger
        console.log('Error:', errorThrown);
        $('#errors').append("<li>I'm afraid it didn't work. :(</li>");
      });
    };
  });
});
