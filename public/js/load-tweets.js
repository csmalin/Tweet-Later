$( document ).ready(function() {

  var name = $('h1.username').html();
  console.log(name);
  $.ajax({
    type: 'get',
    url: '/' + name + '/tweets'
  }).done(function (data) {
    $('#tweet_party').replaceWith(data)
  });

});
