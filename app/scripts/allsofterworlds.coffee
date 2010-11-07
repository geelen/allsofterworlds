proportionScrolled = ->
  ($(window).scrollTop() + $(window).height()) / $('body').height()

currentPos = ->
  current = $('div.article.current')
  (current.offset().top + current.height() - $(window).scrollTop())

shouldMoveNext = ->
  currentPos() < 150

moveNext = ->
  $('div.article.current').removeClass('current').next('div.article').addClass('current')
  if shouldLoadMore()
    loadMore()

shouldLoadMore = ->
  $('div.article.current ~ div.article').length < 4

loadMore = ->
  if !$('#content').hasClass('loading')
    $('#content').addClass('loading')
    from = $('.article:last').attr('data_nr').replace(/\D/g, '')
    $.get "${window.location.pathname}/articles?from=${parseInt(from) + 1}", {}, (data, textStatus) ->
      if textStatus == 'success'
        $('#content .spinner').before(data)
      else
        console.log("failed to load more content")
       $('#content').removeClass('loading')

onScroll = ->
  if shouldMoveNext()
    moveNext()

  if proportionScrolled() > 0.99
    loadMore()

$ ->
  $(window).bind 'scroll', onScroll
  $('div.article:first').addClass('current')

