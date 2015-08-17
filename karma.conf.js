var webpackConfig = require('./webpack.config');
webpackConfig.devtool = 'inline-source-map';

module.exports = function (config) {
  config.set({
    plugins: [
      'karma-jasmine',
      'karma-sourcemap-loader',
      'karma-webpack',
      'karma-firefox-launcher',
    ],
    browsers: ['Firefox'],
    singleRun: true,
    frameworks: [ 'jasmine' ],
    files: [
      'test.webpack.js'
    ],
    preprocessors: {
      'test.webpack.js': [ 'webpack', 'sourcemap' ]
    },
    reporters: [ 'dots' ],
    webpack: webpackConfig,
    webpackServer: {
      noInfo: true //please don't spam the console when running in karma!
    }
  });
};
