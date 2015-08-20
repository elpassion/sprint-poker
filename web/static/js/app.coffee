require 'flexboxgrid'
require 'normalize.css'
require '../css/app.sass'

React = require 'react'
{ Router, Route, Redirect } = require 'react-router'

BrowserHistory = require('react-router/lib/BrowserHistory').default
PlanningPokerApp = require './components/PlanningPokerApp'

NewGame = require './components/NewGame'
GameLobby = require './components/GameLobby'

React.render(
  <Router history={ new BrowserHistory() }>
    <Route components={ PlanningPokerApp }>
      <Redirect from="/" to="new-game" />
      <Route path="new-game" components={ NewGame }/>
      <Route path="games/:gameId" components={ GameLobby }/>
    </Route>
  </Router>
  , document.body
)

