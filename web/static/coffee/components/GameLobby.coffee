React = require 'react'
Reflux = require 'reflux'

Game = require './Game'
JoinGame = require './JoinGame'

Store = require '../stores/Store'
Actions = Store.Actions

GameLobby = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    if @state.currentGame
      <Game id={@props.params.gameId}/>
    else
      <JoinGame id={@props.params.gameId}/>

module.exports = GameLobby
