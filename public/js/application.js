$(document).ready(function() {
  upvote();
  downvote();
});

var upvote = function(){
  $("div.vote-container").on('click', '.upvote', function(e){
    e.preventDefault()
    addUpVote(this)
  })
};

var downvote = function(){
  $("div.vote-container").on('click', '.downvote', function(e){
    e.preventDefault()
    addDownVote(this)
  });
};

var addDownVote = function(a){
  $.ajax({
    method: 'GET',
    url: a['href']
  })
  .done(function(voteStuff){
    var voteObject = JSON.parse(voteStuff)
    $(".vote-count#" + voteObject["type"]+ voteObject["id"]).html(voteObject["votes"])
    $(".fa-caret-down#"+ voteObject["type"]+ voteObject["id"]).css("color", "orange")
  })
};

var addUpVote = function(a){
  $.ajax({
    method: 'GET',
    url: a['href']
  })
  .done(function(voteStuff){
    var voteObject = JSON.parse(voteStuff)
    $(".vote-count#" + voteObject["type"]+ voteObject["id"]).html(voteObject["votes"])
    $(".fa-caret-up#"+ voteObject["type"]+ voteObject["id"]).css("color", "orange")
  })
};
