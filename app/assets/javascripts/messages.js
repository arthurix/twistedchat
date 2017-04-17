var submit_message;
var focus_message;
var activity;
var scroller;

submit_message = function() {
  return $('#message_text').on('keydown', function(event) {
    if (event.keyCode === 13) {
      $('input[type=submit]').click();
      event.target.value = "";
      return event.preventDefault();
    }
  });
};

focus_message = function() {
  return $('#message_text').focus();
};

activity = function(status) {
    $.get({
        url: "/activity",
        data: { message: { status: status } }
    });
};

scroller = function(elem) {
    var height = $(elem)[0].scrollHeight;
    $(elem).stop().animate({ scrollTop: height }, 300);
};


$(document).on('turbolinks:load', function() {
  submit_message();
  scroller("#messages");
  focus_message();

  $(window).on("load", function() {
    window.setTimeout( activity('activate'), 2000 );
  });

  $(window).on("beforeunload", function() {
    activity('deactivate');
  });
});
