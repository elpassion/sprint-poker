require 'bootstrap-sass!./../../../bootstrap-sass.config.js'

React = require 'react'
{ Router, Route, Redirect } = require 'react-router'

BrowserHistory = require('react-router/lib/BrowserHistory').default
PlanningPokerApp = require './components/PlanningPokerApp'

NewGame = require './components/NewGame'
GameLobby = require './components/GameLobby'

App = ->
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

if window.airbrake
  Airbrake = require('airbrake-js')

  airbrake = new Airbrake(window.airbrake)
  airbrake.addFilter (notice) ->
    notice.context.environment = window.airbrake.environment
    notice
  airbrake.wrap(App)()
else
  App()
