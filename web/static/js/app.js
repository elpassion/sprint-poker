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

var user = {name: "Silver Fo", id: "9f79514f-2c72-4bb3-930b-dd45528cad73", auth_token: "a383d3e5-e581-4a3f-9ab1-fe18052541e0"}

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

