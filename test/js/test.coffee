React = require('react')
Errors = require('../../web/static/js/components/Errors')
TestUtils = require('react/lib/ReactTestUtils')

describe 'PlanningPokerApp', ->
  it 'renders', ->
    element = TestUtils.renderIntoDocument(<Errors />)
    expect(element).toBeTruthy()

