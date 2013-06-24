do ($=jQuery) ->
  escapeHtml = (chars) ->
    chars.replace(/&/g,"&amp;").replace(/"/g,"&quot;").replace(/</g,"&lt;").replace(/>/g,"&gt;") #"

  $.SimpleSearch = 
    Target: null
    Form: null
    
    assignSearchTarget: (targetItems) ->
      items: $(targetItems)
      totalNumber: $(targetItems).size()
      matchingItems: (word) ->
        wordPat = new RegExp(word, "i")
        @items.filter((index) -> $(@).text().match(wordPat))

    assignSearchForm: (KeywordFieldId, MessageAreaId, MatchingNumberAreaId, TotalNumberAreaId, ExecuteButtonId, ClearButtonId, totalNumber) ->
      form =
        message: $(MessageAreaId)
        keyword: $(KeywordFieldId)
        matchingNumberArea: $(MatchingNumberAreaId)
        totalNumberArea: $(TotalNumberAreaId)
        executeButton: $(ExecuteButtonId)
        clearButton: $(ClearButtonId)
        setMessage: (word, numberOfMatchedItems) ->
          @matchingNumberArea.text(numberOfMatchedItems)
          @message.text(word)
        clearMessage: ->
          @keyword.focus()
          @keyword.select()
          @setMessage("", totalNumber)

      form.totalNumberArea.text(totalNumber)
      form.executeButton.click => @executeSearch()
      form.clearButton.click => @clearSearch()
      form

    executeSearch: ->
      @Target.items.hide()
      word = escapeHtml(@Form.keyword.val())
      matchingItems = @Target.matchingItems(word)
      matchingItems.show()
      @Form.setMessage(word, matchingItems.size())
      false

    clearSearch: ->
      @Target.items.show()
      @Form.clearMessage()
      false
