UserMixin =
  actions:
    changeUserName: {}
    submitUserName: {}
    validateUserName: {}

  init: ->
    @user = {
      errors: {}
    }
    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "user", (user) =>
        @user = _.merge(@user, user["user"])
        @emit()

  onChangeUserName: (name) ->
    @user.name = name
    @emit()

  onSubmitUserName: ->
    @channel.push('change_user_name', @user)

  onValidateUserName: ->
    @user.errors = {}

    @user.name = _.trim(@user.name)

    @user.errors['name'] = 'Your Nickname Cant be blank' if @user.name == ''
    @user.errors['name'] = 'Your Nichname is too long' if @user.name.length > 254

    @emit()

module.exports = UserMixin
