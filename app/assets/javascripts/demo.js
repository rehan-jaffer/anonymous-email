var loginDemo = {
  
};

$(function() {

  $(".demo-login-form").on("ajax:complete", function(e, xhr, settings, exception) {
    $("#token").text(xhr.responseJSON["token"]);
    $.cookie("auth_token", xhr.responseJSON["token"]);
  });

  $(".mailbox-form").on("ajax:complete", function(e, xhr, settings, exception) {
    $("#mailbox").html(JSON.stringify(xhr.responseJSON))
  });

  $(".demo-account-form").on("ajax:complete", function(e, xhr, settings, exception) {
    _.each(xhr.responseJSON, function(value, key, list) {
      $("#account").append("<h2>" + key + "</h2>\r\n" + "<p>" + value + "</p>\r\n");
    });
  });

});
