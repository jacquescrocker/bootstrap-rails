# setup helpers
# console.log("handlebars helpers")
Handlebars.registerHelper 'inDollars', (input) ->
  cents = parseInt("#{input}", 10)
  price = cents * 0.01
  return parseFloat(price).toFixed(2)

