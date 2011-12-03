# DEV RELOAD FOR JQUERY / UNDERSCORE

$ = jQuery

# add reloadElement to underscore
_.mixin
  # reloads a particular element
  reloadElement: (element) ->
    if element and element.tagName
      tag = element.tagName.toUpperCase()

      # check if its a link or a script
      if tag == "LINK"
        srcAttribute = "href"
      else if tag == "SCRIPT"
        srcAttribute = "src"

      # make the swap
      if srcAttribute
        href = element[srcAttribute].replace(/[?&]reloader=([^&$]*)/,'')
        sep = if href.indexOf("?") >= 0 then "&" else "?"
        element[srcAttribute] = "#{href}#{sep}reloader=#{new Date().valueOf()}"

    return element

$(document).ready ->
  return unless typeof(pusher) == "object"
  return unless typeof(Settings) == "object"
  return unless Settings.dev_reload_channel

  console.log("Setting up dev_reload")

  # setup guardfile
  pusher.subscribe("guard-pusher-#{Settings.dev_reload_channel}").bind 'guard', (e) ->
    # console.log("files have been updated")
    # console.log(e)

    reload = false

    # cycle through paths
    _(e.paths || []).each (path) ->
      console.log("changed: #{path}")

      if _(path).endsWith(".css") or _(path).endsWith(".sass") or _(path).endsWith(".scss") or _(path).endsWith(".styl")
        # lets try to dynamically replace this css file
        console.log("Reloading Inline CSS")

        # swap css files
        _(document.querySelectorAll('link[rel=stylesheet][href]')).each (element) ->
          _(element).reloadElement()

      else
        reload = true

    if reload
      console.log("RELOAD THE PAGE!")
      window.location.reload()