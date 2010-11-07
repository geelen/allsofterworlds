(function(){
  var loadMoreContent, proportionScrolled;
  proportionScrolled = function() {
    var prop;
    prop = ($(window).scrollTop() + $(window).height()) / $('body').height();
    console.log(prop);
    return prop;
  };
  loadMoreContent = function() {
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
  $(function() {
    return $(window).bind('scroll', function() {
      if (proportionScrolled() > 0.9) {
        return loadMoreContent();
      }
    });
  });
})();
