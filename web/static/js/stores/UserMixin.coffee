UserMixin =
  actions:
    changeUserName: {}
    submitUserName: {}
    validateUserName: { sync: true }

  init: ->
    @user = {
      errors: {}
    }
    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "user", (user) =>
        @user = user.user
        @emit()

  onChangeUserName: (name) ->
    @user.name = name
    @emit()

  onSubmitUserName: ->
    @channel.push('update_user', {user: @user})

  onValidateUserName: ->
    @user.errors = {}

    @user.name = _.trim(@user.name)

    @user.errors.name = 'Your Nickname Cant be blank' if @user.name == ''
    @user.errors.name = 'Your Nichname is too long' if @user.name.length > 100

    @emit()

module.exports = UserMixin
