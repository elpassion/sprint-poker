UserMixin =
  actions:
    changeUserName: {}
    submitUserName: {}
    validateUserName: { sync: true }

  init: ->
    @user = {}
    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "user", (user) =>
        unless user.user.name
          user.user.name = @user.name
        @user = user.user
        @emit()

  onChangeUserName: (name) ->
    @user.name = name
    @emit()

  onSubmitUserName: ->
    @channel.push('user:update', {user: @user})

  onValidateUserName: ->
    @errors.user = {}

    @user.name = _.trim(@user.name)

    @errors.user.name = "Your Nickname can`t be blank" if @user.name == ''
    @errors.user.name = 'Your Nichname is too long' if @user.name.length > 100

    @emit()

module.exports = UserMixin
