$(document).ready(function () {

  // question add comment button clicked
  $('.container').on('click', '#question-add-comment', function(event){
      event.preventDefault();
      $('.new-comment-container-question').show();
    });

// question comment submit button clicked
  $('.container').on('click', '#question-add-comment', function(event){
      event.preventDefault();
      $('.new-comment-container-question').show();
    });

  // answer add comment button clicked
  $('.container').on('click', '#answer-add-comment', function(event){
      event.preventDefault();
      alert("answer comment");

      // var ajaxRequest = $.ajax({
      //   url: "/posts/" + articleIDDelete,
      //   type: 'DELETE',
      // })

      // ajaxRequest.done(function(deleteSuccessResponse) {
      //   $('#' + articleIDDelete).remove();
      // });

      // ajaxRequest.fail(function(deleteFailResponse) {
      //   alert("Something broke..." + deleteFailResponse);
      // });
    });

});