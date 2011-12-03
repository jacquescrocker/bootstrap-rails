module ApplicationHelper

  def js_settings
    %{
      <script type="text/javascript" charset="utf-8">
        window.Settings = {};
        Settings.env = "#{Rails.env}";
        Settings.dev_reload_channel = #{Settings.dev_reload_channel.to_json};
        Settings.pusher = {
          enabled: #{Settings.pusher.enabled.to_json},
          key: #{Settings.pusher.key.to_json}
        };
        Settings.client = #{Settings.client.to_hash.to_json};
      </script>
    }.html_safe
  end

  def use_pusher(channel = nil)
    return unless Settings.pusher.enabled

    html = ""
    js = ""

    # make sure pusher tag is only added once
    html << javascript_include_tag("http://js.pusherapp.com/1.9/pusher.min.js")
    js << "window.pusher = new Pusher('#{Settings.pusher.key}');\n"

    # setup channel (if applicable)
    js << "window.channel = window.pusher.subscribe('#{channel}')\n" if channel.present?

    # add js tag, and render to page
    html << javascript_tag(js) if js.present?
    html.html_safe
  end

  # set attributes that display on the body
  def body_attrs(val = nil)
    @body_attrs ||= {}
    @body_attrs = @body_attrs.with_indifferent_access

    # merge values
    @body_attrs.merge!(val.with_indifferent_access) if val.is_a?(Hash)

    @body_attrs
  end

end
