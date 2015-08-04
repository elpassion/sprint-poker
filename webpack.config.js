'use strict';
var webpack = require('webpack');

module.exports = {
  entry: './web/static/js/app.js',
  output: {
    filename: 'main.js',
    path: './priv/static/assets/'
  },
  debug: true,
  devtool: 'source-map',
  stats: {
    colors: true,
    reasons: true
  },
  module: {
    loaders: [{
      test: /\.js$/,
      exclude: /(node_modules)/,
      loader: 'babel-loader'
    }, {
      test: /\.sass/,
      loader: 'style-loader!css-loader!sass-loader?outputStyle=expanded&indentedSyntax'
    }, {
      test: /\.css$/,
      loader: 'style-loader!css-loader'
    }, {
      test: /\.(png|jpg|woff|woff2)$/,
      loader: 'url-loader?prefix=assets/'
    }]
  },
};
