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
      @channel.push('create_ticket', {ticket: @newTicket})
      @newTicket.name = ''

  onDeleteTicket: (id) ->
    @channel.push('delete_ticket', {ticket: {id: id}})

  onChangeTicketName: (id, name) ->
    i = _.findIndex @game.tickets, (ticket) ->
      String(ticket.id) == String(id)
    @game.tickets[i].name = name
    @emit()

  onChangeTicketPoints: (points) ->
    ticket = @game.tickets[@gameState.current_ticket_index]
    ticket.points = points
    @channel.push('update_ticket', {ticket: {id: ticket.id, points: points }})
    @emit()

  onSubmitTicketName: (id, name) ->
    @channel.push('update_ticket', {ticket: {id: id, name: _.trim(name) }})

module.exports = TicketMixin
