#ifndef FLUTTER_PLUGIN_FLUTTER_AUTO_GUI_WINDOWS_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_AUTO_GUI_WINDOWS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_auto_gui_windows
{

    class FlutterAutoGuiPlugin : public flutter::Plugin
    {
    public:
        static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

        FlutterAutoGuiPlugin();

        virtual ~FlutterAutoGuiPlugin();

        // Disallow copy and assign.
        FlutterAutoGuiPlugin(const FlutterAutoGuiPlugin &) = delete;
        FlutterAutoGuiPlugin &operator=(const FlutterAutoGuiPlugin &) = delete;

        // Called when a method is called on this plugin's channel from Dart.
        void HandleMethodCall(
            const flutter::MethodCall<flutter::EncodableValue> &method_call,
            std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
    };

} // namespace flutter_auto_gui_windows

#endif // FLUTTER_PLUGIN_FLUTTER_AUTO_GUI_WINDOWS_PLUGIN_H_
