#-*- coding: utf-8
require 'romankana'

Plugin.create(:nihongo) do
  UserConfig[:nihongo_ni_suru] = true if UserConfig[:nihongo_ni_suru].nil?

  settings "日本語変換" do
    boolean '日本語にする', :nihongo_ni_suru
  end 
  filter_gui_postbox_post do |gui_postbox|
    buf = Plugin.create(:gtk).widgetof(gui_postbox).widget_post.buffer
    text = buf.text
    if UserConfig[:nihongo_ni_suru]
      to = nil
      if /^@[a-zA-Z0-9_]* / =~ text
         tmp = text.split(" ", 2)
         to = tmp[0]
         text = tmp[1]
      end
      str = ""
      str = to unless to.nil?
      str += "\n" unless to.nil?
      str += text.to_hiragana
      buf.text = str
    end
    [gui_postbox]
  end
end
