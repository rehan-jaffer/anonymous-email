var loginDemo = {
  
};

$(function() {

  $(document).on("ajax:beforeSend", function(evt, request, settings) {
    $("#console").append("Starting request at " + settings.url + "\r\n")
  });

  $(document).on("ajax:complete", function(e, xhr, settings) {
    $("#console").append("Received: " + JSON.stringify(xhr.responseJSON) + "\r\n")
  });

  $(".demo-login-form").on("ajax:complete", function(e, xhr, settings, exception) {
    $("#token").text(xhr.responseJSON["token"]);
    $.cookie("auth_token", xhr.responseJSON["token"]);
    $(".auth-token-input").val(xhr.responseJSON["token"]);
  });

  $(".mailbox-form").on("ajax:complete", function(e, xhr, settings, exception) {
    mail = xhr.responseJSON;

    mail_template = "<table class = 'col-md-4'><thead><th class = 'col-md-2'>From</th><th class = 'col-md-2'>Subject</th></thead>"

    rows = _.map(xhr.responseJSON, function(element, index, list) { return '<tr><td class = "col-md-2"><%= element["sender"] %></td><td class = "col-md-2"><%= element["subject"] %></td></tr>' } ).join("\r\n")

    $("#mailbox").html(mail_template + rows)
  });

  $(".demo-account-form").on("ajax:complete", function(e, xhr, settings, exception) {
    _.each(xhr.responseJSON, function(value, key, list) {
      $("#account").append("<h2>" + key + "</h2>\r\n" + "<p>" + value + "</p>\r\n");
    });
  });

});
