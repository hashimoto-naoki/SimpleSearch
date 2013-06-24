$ ->
  $.SimpleSearch.Target = $.SimpleSearch.assignSearchTarget("div.portal-item")
  $.SimpleSearch.Form = $.SimpleSearch.assignSearchForm("#keyword", "#search-message", "#matched-items-number", "#items-total-number", "#extract-items", "#show-all", $.SimpleSearch.Target.totalNumber)
  $.SimpleSearch.Form.clearMessage()
