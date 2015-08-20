TicketMixin =
  actions:
    changeNewTicketName: {}
    submitNewTicket: {}

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

module.exports = TicketMixin
