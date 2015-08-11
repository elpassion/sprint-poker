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
import NewSession from './components/NewSession';

var routes = (
  <Route components={PlanningPokerReactApp}>
    <Redirect from="/" to="new-room" />
    <Route path="new-room" components={NewSession}/>
    <Route path="rooms" components={Room}>
      <Route path="/:uuid" components={RoomLobby}/>
    </Route>
  </Route>
);

React.render(
  <Router history={new BrowserHistory()} children={routes}/>, document.body
);

import { Socket } from 'phoenix';

var user = {name: "Salmon Duck", id: "9f1e913d-7342-4097-bbf2-2da8cc7c9df7"}

var socket = new Socket("ws://localhost:4000/ws");
socket.connect(user);
socket.onOpen(ev => console.log("OPEN", ev));
socket.onError(ev => console.log("ERROR", ev));
socket.onClose(ev => console.log("CLOSE", ev));

var channel = socket.channel('lobby', user)
channel
  .join()
  .receive("ignore", () => console.log("auth error"))
  .receive("ok", () =>
    channel.push("create_game", {name: "new game"})
  )

channel.on("user", (user) => console.log("user", user))
channel.on("scales", (scales) => console.log("scales", scales))
channel.on("game", (game) => console.log("game", game))

