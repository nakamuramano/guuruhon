const { environment } = require('@rails/webpacker')

module.exports = environment


const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)

environment.loaders.forEach(element => {
  environment.loaders.get(element.key).use = environment.loaders.get(element.key).use.filter(rule => rule.loader !== 'postcss-loader')
});