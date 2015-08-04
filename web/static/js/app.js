'use strict';

let Router = ReactRouter
let Route = ReactRouter.Route
let Redirect = ReactRouter.Redirect

var PlanningPokerReactApp = require('./components/PlanningPokerReactApp');
var NewRoom = require('./components/NewRoom');
var RoomLobby = require('./components/RoomLobby');
var Room = require('./components/Room');

var routes = (
  <Route handler={PlanningPokerReactApp}>
    <Route path="new-room" name="new-room" handler={NewRoom}/>
    <Route path="rooms" name="rooms" handler={Room}>
      <Route path="/:uuid" handler={RoomLobby}/>
    </Route>
    <Redirect from="/" to="new-room" />
  </Route>
);

console.log('start');

Router.run(routes, Router.HistoryLocation, function (Handler) {
  React.render(<Handler/>, document.body);
});

// React.render(
//   <Router history={new BrowserHistory()} children={routes}/>, document.body
// );

let App = {};

console.log('123');

export default App;
