require('flexboxgrid');
require('normalize.css');
require('../css/app.sass');

import React from 'react'
import { Router, Route, Redirect } from 'react-router'
import BrowserHistory from 'react-router/lib/BrowserHistory';

import PlanningPokerReactApp from './components/PlanningPokerReactApp';
import NewRoom from './components/NewRoom';
import RoomLobby from './components/RoomLobby';
import Room from './components/Room';
import NewGame from './components/NewGame';

var routes = (
  <Route components={PlanningPokerReactApp}>
    <Redirect from="/" to="new-game" />
    <Route path="new-game" components={NewGame}/>
    <Route path="games" components={Room}>
      <Route path="/:uuid" components={RoomLobby}/>
    </Route>
  </Route>
);

React.render(
  <Router history={new BrowserHistory()} children={routes}/>, document.body
);
