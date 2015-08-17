React = require('react')
PlanningPokerReactApp = require('../../web/static/js/components/PlanningPokerReactApp')
TestUtils = require('react/lib/ReactTestUtils')

describe 'PlanningPokerReactApp', ->
  it 'renders', ->
    element = TestUtils.renderIntoDocument(<PlanningPokerReactApp />)
    expect(element).toBeTruthy()

