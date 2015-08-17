UserMixin =
  actions:
    changeUserName: {}
    submitUserName: {}

  init: ->
    @user = {}
    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "user", (user) =>
        @user = user["user"]
        @emit()

  onChangeUserName: (name) ->
    @user.name = name
    @emit()

  onSubmitUserName: ->
    @channel.push('change_user_name', @user)

module.exports = UserMixin
