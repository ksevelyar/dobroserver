(($) ->
  $(document).ready ->

    # Прячем аватар, если Gravatar вернул 404

    # Спойлер

    #$('article .size-large').parent().colorbox({maxHeight:"90%", maxWidth:"90%"});
    #$('img').animate({max-width:"100%"});
    #$("img").scaleImage();

    # Выделение кода
    select_all = (el) ->
      if typeof window.getSelection isnt "undefined" and typeof document.createRange isnt "undefined"
        range = document.createRange()
        range.selectNodeContents el
        sel = window.getSelection()
        sel.removeAllRanges()
        sel.addRange range
      else if typeof document.selection isnt "undefined" and typeof document.body.createTextRange isnt "undefined"
        textRange = document.body.createTextRange()
        textRange.moveToElementText el
        textRange.select()
    $("img.avatar").error ->
      $(this).unbind("error").hide()

    $("article .spoiler_title").next().hide()
    $("article .spoiler_title").click ->
      $(this).toggleClass("minus").toggleClass("plus").next().toggle()

    $(".select_all").click ->
      select_all $(this).next()[0]

    $("pre code").each (i, e) ->
      hljs.highlightBlock e, "    "

) jQuery
