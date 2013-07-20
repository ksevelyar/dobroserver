$(document).ready ->
  $.ajaxSetup beforeSend: (xhr) ->
    xhr.setRequestHeader "Accept", "text/javascript"

  $("#image_image").change ->
    $.each $("#image_image")[0].files, (i, file) ->
      data = new FormData()
      data.append "image[image]", file
      console.log file
      #data.append "image[blog_record_id]"
      $.ajax
        url: "images"
        data: data
        cache: false
        contentType: false
        processData: false
        type: "POST"

  $("#attachment_attachment").change ->
    $.each $("#attachment_attachment")[0].files, (i, file) ->
      data = new FormData()
      data.append "attachment[attachment]", file
      $.ajax
        url: "attachments"
        data: data
        cache: false
        contentType: false
        processData: false
        type: "POST"


  # Скрываем input элементы
  $(".upload_image").click (e) ->
    e.preventDefault()
    $("#image_image").trigger "click"

  $(".upload_attachment").click (e) ->
    e.preventDefault()
    $("#attachment_attachment").trigger "click"
