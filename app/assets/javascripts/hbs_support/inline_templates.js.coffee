# console.log("handlebars inline templates")

# wire up templates
window.JST ||= {}
window.JST.inline ||= {}

$(".ui-page").live
  'detectHandlebars': (e) ->
    console.log("Detecting handlebars...")
    $(this).find("script[type='text/x-handlebars-template']").each ->
      self = $(this)
      templateName = self.data("template")
      console.log("Compiling: #{templateName}")
      window.JST.inline[templateName] = Handlebars.compile(self.html())

  'pageinit': (e) ->
    $(this).fire("detectHandlebars")
