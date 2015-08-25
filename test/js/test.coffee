React = require('react')
PlanningPokerApp = require('../../web/static/js/components/PlanningPokerApp')
TestUtils = require('react/lib/ReactTestUtils')

describe 'PlanningPokerApp', ->
  it 'renders', ->
    element = TestUtils.renderIntoDocument(<PlanningPokerApp />)
    expect(element).toBeTruthy()

