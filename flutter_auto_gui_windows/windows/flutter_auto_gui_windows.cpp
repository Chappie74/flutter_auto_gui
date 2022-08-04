#include "include/flutter_auto_gui_windows/flutter_auto_gui_windows.h"

#include <flutter/plugin_registrar_windows.h>

#include "src/flutter_auto_gui_plugin.h"

void FlutterAutoGuiWindowsRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar)
{
    flutter_auto_gui_windows::FlutterAutoGuiPlugin::RegisterWithRegistrar(
        flutter::PluginRegistrarManager::GetInstance()
            ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
