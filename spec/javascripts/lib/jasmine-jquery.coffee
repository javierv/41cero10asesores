readFixtures = ->
  jasmine.getFixtures().proxyCallTo_('read', arguments)

loadFixtures = ->
  jasmine.getFixtures().proxyCallTo_('load', arguments)

setFixtures = (html) ->
  jasmine.getFixtures().set(html)

sandbox = (attributes) ->
  jasmine.getFixtures().sandbox(attributes)

spyOnEvent = (selector, eventName) ->
  jasmine.JQuery.events.spyOn(selector, eventName)

jasmine.getFixtures = ->
  jasmine.currentFixtures_ = jasmine.currentFixtures_ || new jasmine.Fixtures()

jasmine.Fixtures = ->
  this.containerId = 'jasmine-fixtures'
  this.fixturesCache_ = {}
  this.fixturesPath = 'spec/javascripts/fixtures'

jasmine.Fixtures.prototype.set = (html) ->
  this.cleanUp()
  this.createContainer_(html)

jasmine.Fixtures.prototype.load = ->
  this.cleanUp()
  this.createContainer_(this.read.apply(this, arguments))

jasmine.Fixtures.prototype.read = ->
  htmlChunks = []

  fixtureUrls = arguments
  for fixtureurl in fixtureUrls
    htmlChunks.push(this.getFixtureHtml_(fixtureurl))

  htmlChunks.join('')

jasmine.Fixtures.prototype.clearCache = ->
  this.fixturesCache_ = {}

jasmine.Fixtures.prototype.cleanUp = ->
  $('#' + this.containerId).remove()

jasmine.Fixtures.prototype.sandbox = (attributes) ->
  attributesToSet = attributes || {}
  $('<div id="sandbox" />').attr(attributesToSet)

jasmine.Fixtures.prototype.createContainer_ = (html) ->
  container = $('<div id="' + this.containerId + '" />')
  container.html(html)
  $('body').append(container)

jasmine.Fixtures.prototype.getFixtureHtml_ = (url) ->
  if (typeof this.fixturesCache_[url] == 'undefined')
    this.loadFixtureIntoCache_(url)

  this.fixturesCache_[url]

jasmine.Fixtures.prototype.loadFixtureIntoCache_ = (relativeUrl) ->
  self = this
  url = this.fixturesPath.match('/$') ? this.fixturesPath + relativeUrl : this.fixturesPath + '/' + relativeUrl
  $.ajax {
    async: false, # must be synchronous to guarantee that no tests are run before fixture is loaded
    cache: false,
    dataType: 'html',
    url: url,
    success: (data) ->
      self.fixturesCache_[relativeUrl] = data
  }

jasmine.Fixtures.prototype.proxyCallTo_ = (methodName, passedArguments) ->
  this[methodName].apply(this, passedArguments)

jasmine.JQuery = ->

jasmine.JQuery.browserTagCaseIndependentHtml = (html) ->
  $('<div/>').append(html).html()

jasmine.JQuery.elementToString = (element) ->
  $('<div />').append(element.clone()).html()

jasmine.JQuery.matchersClass = {}

(
  (namespace) ->
    data = {
      spiedEvents: {},
      handlers:    []
    }

    namespace.events = {
      spyOn: (selector, eventName) ->
        handler = (e) ->
          data.spiedEvents[[selector, eventName]] = e

        $(selector).bind(eventName, handler)
        data.handlers.push(handler)
      ,

      wasTriggered: (selector, eventName) ->
        !!(data.spiedEvents[[selector, eventName]])
      ,

      cleanUp: ->
        data.spiedEvents = {}
        data.handlers    = []
    }
)(jasmine.JQuery)

(
  ->
    jQueryMatchers = {
      toHaveClass: (className) ->
        this.actual.hasClass(className)
      ,

      toBeVisible: ->
        this.actual.is(':visible')
      ,

      toBeHidden: ->
        this.actual.is(':hidden')
      ,

      toBeSelected: ->
        this.actual.is(':selected')
      ,

      toBeChecked: ->
        this.actual.is(':checked')
      ,

      toBeEmpty: ->
        this.actual.is(':empty')
      ,

      toExist: ->
        this.actual.size() > 0
      ,

      toHaveAttr: (attributeName, expectedAttributeValue) ->
        hasProperty(this.actual.attr(attributeName), expectedAttributeValue)
      ,

      toHaveId: (id) ->
        this.actual.attr('id') == id
      ,

      toHaveHtml: (html) ->
        this.actual.html() == jasmine.JQuery.browserTagCaseIndependentHtml(html)
      ,

      toHaveText: (text) ->
        if (text && jQuery.is(text.test))
          text.test(this.actual.text())
        else
          this.actual.text() == text
      ,

      toHaveValue: (value) ->
        this.actual.val() == value
      ,

      toHaveData: (key, expectedValue) ->
        hasProperty(this.actual.data(key), expectedValue)
      ,

      toBe: (selector) ->
        this.actual.is(selector)
      ,

      toContain: (selector) ->
        this.actual.find(selector).size() > 0
      ,

      toBeDisabled: (selector) ->
        this.actual.attr("disabled") == true
    }

    hasProperty = (actualValue, expectedValue) ->
      if (expectedValue == undefined)
        actualValue != undefined
      
      actualValue == expectedValue
    
    bindMatcher = (methodName) ->
      builtInMatcher = jasmine.Matchers.prototype[methodName]

      jasmine.JQuery.matchersClass[methodName] = ->
        if (this.actual instanceof jQuery)
          result = jQueryMatchers[methodName].apply(this, arguments)
          this.actual = jasmine.JQuery.elementToString(this.actual)
          result

        if (builtInMatcher)
          builtInMatcher.apply(this, arguments)

        false

    for methodName in jQueryMatchers
      bindMatcher(methodName)
)()

beforeEach ->
  this.addMatchers(jasmine.JQuery.matchersClass)
  this.addMatchers {
    toHaveBeenTriggeredOn: (selector) ->
      this.message = ->
        [
          "Expected event " + this.actual + " to have been triggered on" + selector,
          "Expected event " + this.actual + " not to have been triggered on" + selector
        ]
      jasmine.JQuery.events.wasTriggered(selector, this.actual)
  }

afterEach ->
  jasmine.getFixtures().cleanUp()
  jasmine.JQuery.events.cleanUp()
