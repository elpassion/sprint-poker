TicketMixin =
  actions:
    changeNewTicketName: {}
    submitNewTicket: {}
    deleteTicket: {}
    changeTicketName: {}
    submitTicketName: {}
    changeTicketPoints: {}

  init: ->
    @newTicket = {}

  onChangeNewTicketName: (name) ->
    @newTicket.name = name
    @emit()

  onSubmitNewTicket: ->
    @newTicket.name = _.trim(@newTicket.name)

    if @newTicket.name != '' && @newTicket.name.length < 100
      @channel.push 'ticket:create', {ticket: @newTicket}
      @newTicket.name = ''

  onDeleteTicket: (id) ->
    @channel.push 'ticket:delete', {ticket: {id: id}}

  onChangeTicketName: (id, name) ->
    @game.tickets[id].name = name
    @emit()

  onChangeTicketPoints: (points) ->
    if points == "" then points = null
    ticket = @game.tickets[@gameState.currentTicketId]
    ticket.points = points
    @channel.push 'ticket:update', {ticket: {id: ticket.id, points: points }}
    @emit()

  onSubmitTicketName: (id, name) ->
    @channel.push 'ticket:update', {ticket: {id: id, name: _.trim(name) }}

module.exports = TicketMixin
