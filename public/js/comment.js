$(document).ready(function () {

  // question add comment button clicked
  $('.container').on('click', '#question-add-comment', function(event){
      event.preventDefault();
      $('.new-comment-container-question').show();
    });

  // question form submit button clicked
  $('.container').on('submit', '#question_comment', function(event){
      "use strict"
      var allData
      event.preventDefault();

      allData = $(this).serialize();

      var ajaxRequest = $.ajax({
        url: "/comments/new",
        type: 'POST',
        data: allData
      })

      ajaxRequest.done(function(successResponse) {
        $('.new-comment-container-question').hide();
        $("#question_comment")[0].reset();
        $('.all-comments').append(successResponse);
      });

      ajaxRequest.fail(function(failResponse) {
        console.log(failResponse);
        $('.new-comment-container-question').hide();
        $("#question_comment")[0].reset();
        alert("You must be logged in to post a comment.")
      });
    });

  // answer add comment button clicked
  $('.container').on('click', '.answer-add-comment', function(event){
      event.preventDefault();
      $(this).parent().parent().children(".new-comment-container").show();
    });

  // answer form submit button clicked
  $('.container').on('submit', '#answer_comment', function(event){
      "use strict"
      var allData, formInfo
      event.preventDefault();

      allData = $(this).serialize();
      formInfo = $(this)

      var ajaxRequest = $.ajax({
        url: "/comments/new",
        type: 'POST',
        data: allData
      })

      ajaxRequest.done(function(successResponse) {
        formInfo.parent().append(successResponse);
        formInfo.hide();
      });

      ajaxRequest.fail(function(failResponse) {
        console.log(failResponse);
        formInfo.hide();
        alert("You must be logged in to post a comment.")
      });
    });

});