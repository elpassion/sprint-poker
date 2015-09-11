React = require('react')
Errors = require('../../web/static/coffee/components/Errors')
TestUtils = require('react/lib/ReactTestUtils')

describe 'SprintPokerApp', ->
  it 'renders', ->
    element = TestUtils.renderIntoDocument(<Errors />)
    expect(element).toBeTruthy()

