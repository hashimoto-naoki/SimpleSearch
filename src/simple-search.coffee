# Copyright (c) 2013 HASHIMOTO, Naoki
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

do ($=jQuery) ->
  escapeHtml = (chars) ->
    chars.replace(/&/g,"&amp;").replace(/"/g,"&quot;").replace(/</g,"&lt;").replace(/>/g,"&gt;") #"

  $.fn.matching = (wordPat) ->
    @text().match(wordPat)

  $.SimpleSearch = 
    Target: null
    Form: null
    
    assignSearchTarget: (targetItems, targetSubItems) ->
      items: $(targetItems)
      subItems: $(targetSubItems)
      subItemsClass: targetSubItems
      totalNumber: $(targetItems).size()
      matchingItems: (word) ->
        wordPat = new RegExp(word, "i")
        @items.filter((index) -> $(@).text().match(wordPat))

    assignSearchForm: (KeywordFieldId, MessageAreaId, MatchingNumberAreaId, TotalNumberAreaId, ExecuteButtonId, ClearButtonId) ->
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
          @setMessage("", $.SimpleSearch.Target.totalNumber)

      form.totalNumberArea.text(@Target.totalNumber)
      form.executeButton.click => @executeSearch()
      form.clearButton.click => @clearSearch()
      form

    executeSearch: ->
      @Target.items.hide()
      word = escapeHtml(@Form.keyword.val())
      matchingItems = @Target.matchingItems(word)
      matchingItems.show()
      wordPat = new RegExp(word, "i")
      matchingItems.each (index) ->
        heading = $(@).children().first()
        unless heading.matching(wordPat)
          $(@).children($.SimpleSearch.Target).filter((index) -> not $(@).matching(wordPat)).hide()
          heading.show()
      @Form.setMessage(word, matchingItems.length)
      false

    clearSearch: ->
      @Target.items.show()
      @Target.subItems.show()
      @Form.clearMessage()
      false

    setup: (targetItems, targetSubItems, KeywordFieldId, MessageAreaId, MatchingNumberAreaId, TotalNumberAreaId, ExecuteButtonId, ClearButtonId) ->
      @Target = @assignSearchTarget(targetItems, targetSubItems)
      @Form = @assignSearchForm(KeywordFieldId, MessageAreaId, MatchingNumberAreaId, TotalNumberAreaId, ExecuteButtonId, ClearButtonId)
      @Form.clearMessage()
