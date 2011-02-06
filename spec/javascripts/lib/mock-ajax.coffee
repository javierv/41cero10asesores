###
Jasmine-Ajax : a set of helpers for testing AJAX requests under the Jasmine
BDD framework for JavaScript.

Supports both Prototype.js and jQuery.

http://github.com/pivotal/jasmine-ajax

Jasmine Home page: http://pivotal.github.com/jasmine

Copyright (c) 2008-2010 Pivotal Labs

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
###

# Jasmine-Ajax interface
ajaxRequests = []

mostRecentAjaxRequest = ->
  if (ajaxRequests.length > 0)
    return ajaxRequests[ajaxRequests.length - 1]
  else
    return null

clearAjaxRequests = ->
  ajaxRequests = []


# Fake XHR for mocking Ajax Requests & Responses
FakeXMLHttpRequest ->
  xhr = {
    requestHeaders: {},

    open: ->
      xhr.method = arguments[0]
      xhr.url = arguments[1]
      xhr.readyState = 1
    ,

    setRequestHeader: (header, value) ->
      xhr.requestHeaders[header] = value
    ,

    abort: ->
      xhr.readyState = 0
    ,

    readyState: 0,

    onreadystatechange: ->
    ,

    status: null,

    send: (data) ->
      xhr.params = data
      xhr.readyState = 2
    ,

    getResponseHeader: (name) ->
      return xhr.responseHeaders[name]
    ,

    responseText: null,

    response: (response) ->
      xhr.status = response.status
      xhr.responseText = response.responseText || ""
      xhr.readyState = 4
      xhr.responseHeaders = response.responseHeaders ||
      {"Content-type": response.contentType || "application/json" }

      xhr.onreadystatechange()
  }

  xhr
