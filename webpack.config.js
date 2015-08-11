'use strict';
var webpack = require('webpack');

module.exports = {
  entry: './web/static/js/app.js',
  output: {
    filename: 'main.js',
    path: './priv/static/assets/'
  },
  resolve: {
    extensions: ['', '.js', '.cjsx', '.coffee'],
    modulesDirectories: [
      './node_modules',
      './deps/phoenix/web/static/js',
      './deps/phoenix_html/web/static/js'
    ],
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
      loader: 'babel-loader?stage=0'
    }, {
      test: /\.sass/,
      loader: 'style-loader!css-loader!sass-loader?outputStyle=expanded&indentedSyntax'
    }, {
      test: /\.css$/,
      loader: 'style-loader!css-loader'
    }, {
      test: /\.(png|jpg|woff|woff2)$/,
      loader: 'url-loader?prefix=assets/'
    },{
      test: /\.(cjsx|coffee)$/,
      loader: "coffee-jsx-loader"
    }]
  },
};
