$ ->
  $.SimpleSearch.Target = $.SimpleSearch.assignSearchTarget("div.h2")
  $.SimpleSearch.Form = $.SimpleSearch.assignSearchForm("#keyword", "#search-message", "#matched-items-number", "#items-total-number", "#extract-items", "#show-all", $.SimpleSearch.Target.totalNumber)
  $.SimpleSearch.Form.clearMessage()
