require 'bootstrap-sass!./../../../bootstrap-sass.config.js'

React = require 'react'
{ Router, Route, Redirect } = require 'react-router'

BrowserHistory = require('react-router/lib/BrowserHistory').default
SprintPokerApp = require './components/SprintPokerApp'

NewGame = require './components/NewGame'
GameLobby = require './components/GameLobby'

if window.airbrake
  Airbrake = require('airbrake-js')
  airbrake = new Airbrake(window.airbrake)
  airbrake.addFilter (notice) ->
    notice.context.environment = window.airbrake.environment
    notice

  window.onerror = (message, file, line, col, error) ->
    if error
      airbrake.notify(error)
    else
      airbrake.notify
        error:
          message: message,
          fileName: file,
          lineNumber: line

React.render(
  <Router history={ new BrowserHistory() }>
    <Route components={ SprintPokerApp }>
      <Redirect from="/" to="new-game" />
      <Route path="new-game" components={ NewGame }/>
      <Route path="games/:gameId" components={ GameLobby }/>
    </Route>
  </Router>
  , document.getElementById('app')
)
