$(document).ready(function(){
  var pass = true ;
  var url = null;
  var temp = 0;
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
      // $('#tweet_form input').attr({'disabled':'true'});
      $('#errors').append("<li>We're processing your tweet, sire.</li>");

      $.ajax({
        method: 'POST',
        data: {tweet: $('#tweet').val()},
        url: '/'
      }).done (function(data){
        // debugger
        // console.log(data);
        $('#tweet_form#tweet').val('');
        $('#errors').append("<li>It worked! You're amazing!</li>");
        url = data
        console.log('http://localhost:9292' + url)
      }).fail (function(jqXHR, textStatus, errorThrown){
        // debugger
        console.log('Error:', errorThrown);
        $('#errors').append("<li>I'm afraid it didn't work. :(</li>");
      });
    };
  });


  
    // console.log(temp);
  var jobDone = setInterval(function(){
    if (temp==0){
    $.ajax({
      url: 'http://localhost:9292' + url,
      data: " ",
      method: 'get'
    })
    .done(function(data){
      console.log(data)
      if(data == 'false'){
        console.log(data + "in the if");
        $('span.loading').append(".")
      }
      else{
        console.log("finished")
        console.log(data + "in the else bro")
        $('div.loading').children().remove()
        $('div.loading').append("AIN'T NOBODY GOT TIME FOR TWITTER ")
        temp = 1
        // $('span.loading').remove().append("DONEEE")
      }
    })
  }
  }, 20)


});
