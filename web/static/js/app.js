require('../css/app.sass');

import React from 'react'
import { Router, Route, Redirect } from 'react-router'
import BrowserHistory from 'react-router/lib/BrowserHistory';

import PlanningPokerReactApp from './components/PlanningPokerReactApp';
import NewRoom from './components/NewRoom';
import RoomLobby from './components/RoomLobby';
import Room from './components/Room';

var routes = (
  <Route components={PlanningPokerReactApp}>
    <Redirect from="/" to="new-room" />
    <Route path="new-room" components={NewRoom}/>
    <Route path="rooms" components={Room}>
      <Route path="/:uuid" components={RoomLobby}/>
    </Route>
  </Route>
);

console.log('start');

// Router.run(routes, Router.HistoryLocation, function (Handler) {
//   React.render(<Handler/>, document.body);
// });
//
React.render(
  <Router history={new BrowserHistory()} children={routes}/>, document.body
);

let App = {};

console.log('123');

export default App;
