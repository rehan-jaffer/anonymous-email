var loginDemo = {
  
};

$(function() {

  $(document).on("ajax:beforeSend", function(evt, request, settings) {
    $("#console").append("Starting request at " + settings.url + "\r\n")
    $("#console").scrollTop(($("#console").scrollTop()+50))
  });

  $(document).on("ajax:complete", function(e, xhr, settings) {
    $("#console").append("Received: " + JSON.stringify(xhr.responseJSON) + "\r\n")
    $("#console").scrollTop(($("#console").scrollTop()+300))
  });

  $(".demo-login-form").on("ajax:complete", function(e, xhr, settings, exception) {
    $("#token").text(xhr.responseJSON["token"]);
    $.cookie("auth_token", xhr.responseJSON["token"]);
    $(".auth-token-input").val(xhr.responseJSON["token"]);
  });

  $(".registration-form").on("ajax:success", function(e, xhr, settings, exception) {
    $("#email_address").text(xhr.responseJSON["anonymous_email"]);
    $("#email_address").append("<br /><br />A confirmation email was sent to the email address you supplied, you will need to confirm it before using the rest of the functionality");
  });

  $(".mailbox-form").on("ajax:complete", function(e, xhr, settings, exception) {
    mail = xhr.responseJSON;

    mail_template = "<table class = 'col-md-8'><thead><th class = 'col-md-2'>From</th><th class = 'col-md-2'>Subject</th><th class = 'col-md-2'>Has Attachments</th></thead>"

    rows = _.map(xhr.responseJSON, function(element, index, list) { return '<tr><td class = "col-md-2">' + element["sender"] + ' / ' + element["name"] + '</td><td class = "col-md-2"><a class = "mail" data-guid="' + element["uid"]  + '">' + element["subject"] + '</a></td><td><a href = "#">' + element["has_attachments"] + '</a></td></tr>' } ).join("\r\n")

    $("#mailbox").html(mail_template + rows)

      $(".mail").on("click", function(e) {

        $.ajax({
         method: "GET",
         url: "/api/mail/" + $(this).data("guid") + ".json?token=" + $.cookie("auth_token"),
         }).done(function(data) {
         alert(JSON.stringify(data));
         }).error(function(data) {
         alert(JSON.stringify(data));
        });


    });

  });

  $(".demo-account-form").on("ajax:complete", function(e, xhr, settings, exception) {
      $("#account").html("");
    _.each(xhr.responseJSON, function(value, key, list) {
      $("#account").append("<h2>" + key + "</h2>\r\n" + "<p>" + value + "</p>\r\n");
    });
  });

});
