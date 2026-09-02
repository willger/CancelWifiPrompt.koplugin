local Device = require("device")
local _ = require("gettext")
local UIManager = require("ui/uimanager")
local WidgetContainer = require("ui/widget/container/widgetcontainer")

local WIFI_PROMPT = _("Do you want to turn on Wi-Fi?")

if not UIManager._cancel_wifi_prompt_orig_show then
    UIManager._cancel_wifi_prompt_orig_show = UIManager.show
    UIManager.show = function(self, widget, ...)
        if Device:isAndroid()
                and widget
                and widget.text == WIFI_PROMPT then
            widget.cancel_callback()
            return
        end
        return UIManager._cancel_wifi_prompt_orig_show(self, widget, ...)
    end
end

local CancelWifiPrompt = WidgetContainer:extend{
    name = "CancelWifiPrompt",
}

return CancelWifiPrompt