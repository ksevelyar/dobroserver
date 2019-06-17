$(document).ready ->
  $.fn.extend insertAtCaret: (myValue) ->
    @each (i) ->
      if document.selection
        #For browsers like Internet Explorer
        @focus()
        sel = document.selection.createRange()
        sel.text = myValue
        @focus()
      else if @selectionStart or @selectionStart is "0"
        #For browsers like Firefox and Webkit based
        startPos = @selectionStart
        endPos = @selectionEnd
        scrollTop = @scrollTop
        @value = @value.substring(0, startPos) + myValue + @value.substring(endPos, @value.length)
        @focus()
        @selectionStart = startPos + myValue.length
        @selectionEnd = startPos + myValue.length
        @scrollTop = scrollTop
      else
        @value += myValue
        @focus()

  $("#filelist").on "click", "a.insert", ->
    image = $(this).children("img")
    if image.hasClass("preview")
      preview = image.attr("src")
      image   = preview.replace(/preview_/, "")

      $("textarea").insertAtCaret "[![](" + preview + ")](" + image + ")"
    else
      $("textarea").insertAtCaret "![](" + image.attr("src") + ")"
