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

var routes = (
  <Route components={PlanningPokerReactApp}>
    <Redirect from="/" to="new-room" />
    <Route path="new-room" components={NewRoom}/>
    <Route path="rooms" components={Room}>
      <Route path="/:uuid" components={RoomLobby}/>
    </Route>
  </Route>
);

React.render(
  <Router history={new BrowserHistory()} children={routes}/>, document.body
);

import { Socket } from 'phoenix';

var socket = new Socket("ws://localhost:4000/ws");
socket.connect();
socket.onOpen(ev => console.log("OPEN", ev));
socket.onError(ev => console.log("ERROR", ev));
socket.onClose(ev => console.log("CLOSE", ev));

var channel = socket.channel('lobby',  {name: "Plum Goat", id: "dff8aea7-22ed-4fb7-8270-918d14e074fe"})
channel
  .join()
  .receive("ignore", () => console.log("auth error"))
  .receive("ok", () =>
channel.push("update_user", {name: "Terefere", id: "dff8aea7-22ed-4fb7-8270-918d14e074fe"})

          )

channel.on("user", (user) => console.log("user", user))
channel.on("scales", (scales) => console.log("scales", scales))

