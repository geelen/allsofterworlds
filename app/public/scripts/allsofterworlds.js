(function(){
  var loadMoreContent, proportionScrolled;
  proportionScrolled = function() {
    return ($('body').scrollTop() + $(window).height()) / $('body').height();
  };
  loadMoreContent = function() {
    var from;
    if (!$('#content').hasClass('loading')) {
      $('#content').addClass('loading');
      from = $('section.article:last p.heading a.original').html().replace(/\D/g, '');
      console.log(from);
      return $.get(("/articles?from=" + (parseInt(from) - 1)), {}, function(data, textStatus) {
        textStatus === 'success' ? $('#content .spinner').before(data) : console.log("failed to load more content");
        return $('#content').removeClass('loading');
      });
    }
  };
  $(function() {
    return $(window).bind('scroll', function() {
      if (proportionScrolled() > 0.9) {
        return loadMoreContent();
      }
    });
  });
})();
