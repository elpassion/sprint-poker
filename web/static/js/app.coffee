require 'flexboxgrid'
require 'normalize.css'
require '../css/app.sass'

React = require 'react'
{ Router, Route, Redirect } = require 'react-router'

BrowserHistory = require('react-router/lib/BrowserHistory').default
PlanningPokerReactApp = require './components/PlanningPokerReactApp'
NewRoom = require './components/NewRoom'
RoomLobby = require './components/RoomLobby'
Room = require './components/Room'
NewGame = require './components/NewGame'
Game = require './components/Game'

React.render(
  <Router history={ new BrowserHistory() }>
    <Route components={ PlanningPokerReactApp }>
      <Redirect from="/" to="new-game" />
      <Route path="new-game" components={ NewGame }/>
      <Route path="games/:uuid" components={ Game }/>
    </Route>
  </Router>
  , document.body
)

