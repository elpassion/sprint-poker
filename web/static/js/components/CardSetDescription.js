import React from 'react';

var CardSetDescription = React.createClass({
  propTypes: {
    description: React.PropTypes.arrayOf(React.PropTypes.string).isRequired
  },

  getDefaultProps: function() {
    return {
      description: []
    };
  },

  shouldComponentUpdate: function() {
    return true;
  },

  render: function () {
    return (
        <div className="description col-xs-12">{this.props.description.join(', ')}</div>
      );
  }
});

export default CardSetDescription;
