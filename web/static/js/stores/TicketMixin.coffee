TicketMixin =
  actions:
    changeNewTicketName: {}
    submitNewTicket: {}
    validateNewTicketName: { sync: true }

  init: ->
    @newTicket = {}

  onChangeNewTicketName: (name) ->
    @newTicket.name = name
    @emit()

  onSubmitNewTicket: ->
    @channel.push('new_ticket', @newTicket)
    @newTicket.name = ''

module.exports = TicketMixin
