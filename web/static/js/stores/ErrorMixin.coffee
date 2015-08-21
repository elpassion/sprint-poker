ErrorMixin =
  init: ->
    @errors = {
    }
    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "error", (error) =>
        console.log(error)

module.exports = ErrorMixin

