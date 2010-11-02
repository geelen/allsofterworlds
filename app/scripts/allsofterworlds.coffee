proportionScrolled = ->
  prop = ($(window).scrollTop() + $(window).height()) / $('body').height()
  console.log(prop)
  prop

loadMoreContent = ->
  if !$('#content').hasClass('loading')
    $('#content').addClass('loading')
    from = $('section.article:last p.heading a.original').html().replace(/\D/g, '')
    $.get "/articles?from=${parseInt(from) - 1}", {}, (data, textStatus) ->
      if textStatus == 'success'
        $('#content .spinner').before(data)
      else
        console.log("failed to load more content")

      $('#content').removeClass('loading')

$ ->
  $(window).bind 'scroll', -> loadMoreContent() if proportionScrolled() > 0.9

