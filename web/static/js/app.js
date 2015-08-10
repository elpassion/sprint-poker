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

var user = {name: "Green Vixen", id: "8f9bddc4-fb69-4bde-8081-f3728eddee09"}

var channel = socket.channel('lobby', user)
channel
  .join()
  .receive("ignore", () => console.log("auth error"))
  .receive("ok", () =>
    channel.push("create_session", {name: "new session", owner: user})
  )

channel.on("user", (user) => console.log("user", user))
channel.on("scales", (scales) => console.log("scales", scales))
channel.on("session", (session) => console.log("session", session))

