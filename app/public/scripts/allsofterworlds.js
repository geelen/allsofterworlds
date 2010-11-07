(function(){
  var currentPos, loadMore, moveNext, onScroll, proportionScrolled, shouldLoadMore, shouldMoveNext;
  proportionScrolled = function() {
    return ($(window).scrollTop() + $(window).height()) / $('body').height();
  };
  currentPos = function() {
    var current;
    current = $('div.article.current');
    return current.offset().top + current.height() - $(window).scrollTop();
  };
  shouldMoveNext = function() {
    return currentPos() < 150;
  };
  moveNext = function() {
    return $('div.article.current').removeClass('current').next('div.article').addClass('current');
  };
  shouldLoadMore = function() {
    return $('div.article.current ~ div.article').length < 4;
  };
  loadMore = function() {
    var from;
    if (!$('#content').hasClass('loading')) {
      $('#content').addClass('loading');
      from = $('.article:last').attr('data_nr').replace(/\D/g, '');
      return $.get(("" + (window.location.pathname) + "/articles?from=" + (parseInt(from) + 1)), {}, function(data, textStatus) {
        textStatus === 'success' ? $('#content .spinner').before(data) : console.log("failed to load more content");
        return $('#content').removeClass('loading');
      });
    }
  };
  onScroll = function() {
    console.log(currentPos());
    shouldMoveNext() ? moveNext() : null;
    if (proportionScrolled() > 0.99) {
      return loadMore();
    }
  };
  $(function() {
    $(window).bind('scroll', onScroll);
    return $('div.article:first').addClass('current');
  });
})();
