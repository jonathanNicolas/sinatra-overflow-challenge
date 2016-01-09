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
        $('.all-comments').append(successResponse);
        $('.new-comment-container-question').hide();
        $("#question_comment")[0].reset();
      });

      ajaxRequest.fail(function(failResponse) {
        alert("Something broke... Check the log.");
        console.log(failResponse);
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
        formInfo.parent().parent().append(successResponse);
        // formInfo.parent().parent('.all-comments').css("background-color", "yellow");
        // $('.new-comment-container-question').hide();
        formInfo.hide();
        // $("#question_comment")[0].reset();
      });

      ajaxRequest.fail(function(failResponse) {
        alert("Something broke... Check the log.");
        console.log(failResponse);
      });
    });

});