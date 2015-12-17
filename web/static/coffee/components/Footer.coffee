React = require 'react'

Footer = React.createClass
  render: ->
    appVersion = window.APP_VERSION || ''
    sep = do ->
      <span className="sep">{'|'}</span>

    <footer className="page-footer">
      <p>
        {'© 2015 '}
        <a href={"http://elpassion.com"}>{'EL Passion'}</a>
        {sep}{'Sprint Poker '}{appVersion}{sep}{'Fork me on '}
        <a href={"https://github.com/elpassion/sprint-poker"}>{'GitHub'}</a>
        {sep}{'Send us your feedback:'} <a href={"mailto:poker@elpassion.com"}>{'poker@elpassion.com'}</a>
      </p>
    </footer>

module.exports = Footer
