TicketMixin =
  actions:
    changeNewTicketName: {}
    submitNewTicket: {}
    deleteTicket: {}

  init: ->
    @newTicket = {}

  onChangeNewTicketName: (name) ->
    @newTicket.name = name
    @emit()

  onSubmitNewTicket: ->
    @newTicket.name = _.trim(@newTicket.name)

    if @newTicket.name != '' && @newTicket.name.length < 100
      @channel.push('new_ticket', @newTicket)
      @newTicket.name = ''

  onDeleteTicket: (id) ->
    console.log(id)
    @channel.push('delete_ticket', {ticket: {id: id}})

module.exports = TicketMixin
