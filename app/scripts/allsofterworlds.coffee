proportionScrolled = -> ($('body').scrollTop() + $(window).height()) / $('body').height()
loadMoreContent = ->
  if !$('#content').hasClass('loading')
    $('#content').addClass('loading')
    from = $('section.article:last p.heading a.original').html().replace(/\D/g, '')
    console.log(from)
    $.get "/articles?from=${parseInt(from) - 1}", {}, (data, textStatus) ->
      if textStatus == 'success'
        $('#content .spinner').before(data)
      else
        console.log("failed to load more content")

      $('#content').removeClass('loading')

$ ->
  $(window).bind 'scroll', -> loadMoreContent() if proportionScrolled() > 0.9

