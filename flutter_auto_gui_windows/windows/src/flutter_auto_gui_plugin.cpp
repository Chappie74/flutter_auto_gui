#include <windows.h>
#include <VersionHelpers.h>
#include "flutter_auto_gui_plugin.h"
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include "mouse/flutter_auto_gui_windows_mouse.h"
#include "keyboard/flutter_auto_gui_windows_keyboard.h"
#include "utils.h"

#include <memory>
#include <sstream>
#include <string>
#include <list>

namespace flutter_auto_gui_windows
{

    // static
    void FlutterAutoGuiPlugin::RegisterWithRegistrar(
        flutter::PluginRegistrarWindows *registrar)
    {
        auto channel =
            std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
                registrar->messenger(), "flutter_auto_gui_windows",
                &flutter::StandardMethodCodec::GetInstance());

        auto plugin = std::make_unique<FlutterAutoGuiPlugin>();

        channel->SetMethodCallHandler(
            [plugin_pointer = plugin.get()](const auto &call, auto result)
            {
                plugin_pointer->HandleMethodCall(call, std::move(result));
            });

        registrar->AddPlugin(std::move(plugin));
    }

    FlutterAutoGuiPlugin::FlutterAutoGuiPlugin() {}

    FlutterAutoGuiPlugin::~FlutterAutoGuiPlugin() {}

    void FlutterAutoGuiPlugin::HandleMethodCall(
        const flutter::MethodCall<flutter::EncodableValue> &method_call,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
    {
        if (method_call.method_name().compare("position") == 0)
        {
            POINT p = automator::MouseAPI::position();
            result->Success(flutter::EncodableValue(flutter::EncodableMap{
                {flutter::EncodableValue("x"), flutter::EncodableValue(p.x)},
                {flutter::EncodableValue("y"), flutter::EncodableValue(p.y)},
            }));
        }
        else if (method_call.method_name().compare("move") == 0)
        {
            const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
            assert(arguments);

            auto *sleep = std::get_if<int>(&(arguments->find(flutter::EncodableValue("sleep"))->second));
            auto *steps = std::get_if<flutter::EncodableList>(&(arguments->find(flutter::EncodableValue("steps"))->second));

            automator::MouseAPI::move(Utils::parsePointsList(*steps), *sleep);
            result->Success();
        }
        else if (method_call.method_name().compare("drag") == 0)
        {
            const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
            assert(arguments);

            auto *sleep = std::get_if<int>(&(arguments->find(flutter::EncodableValue("sleep"))->second));
            auto *steps = std::get_if<flutter::EncodableList>(&(arguments->find(flutter::EncodableValue("steps"))->second));
            auto *button = std::get_if<std::string>(&(arguments->find(flutter::EncodableValue("button"))->second));

            automator::MouseAPI::drag(Utils::parsePointsList(*steps), *sleep, *button);
            result->Success();
        }
        else if (method_call.method_name().compare("mouseDown") == 0)
        {
            const auto *button = std::get_if<std::string>(method_call.arguments());
            assert(button);

            automator::MouseAPI::mouseDown(*button);
            result->Success();
        }
        else if (method_call.method_name().compare("mouseUp") == 0)
        {
            const auto *button = std::get_if<std::string>(method_call.arguments());
            assert(button);

            automator::MouseAPI::mouseUp(*button);
            result->Success();
        }
        else if (method_call.method_name().compare("click") == 0)
        {
            const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
            assert(arguments);

            auto *interval = std::get_if<int>(&(arguments->find(flutter::EncodableValue("interval"))->second));
            auto *clicks = std::get_if<int>(&(arguments->find(flutter::EncodableValue("clicks"))->second));
            auto *button = std::get_if<std::string>(&(arguments->find(flutter::EncodableValue("button"))->second));

            automator::MouseAPI::click(*button, *clicks, *interval);
            result->Success();
        }
        else if (method_call.method_name().compare("scroll") == 0)
        {
            const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
            assert(arguments);

            auto *clicks = std::get_if<int>(&(arguments->find(flutter::EncodableValue("clicks"))->second));
            auto *axis = std::get_if<std::string>(&(arguments->find(flutter::EncodableValue("axis"))->second));

            automator::MouseAPI::scroll(*axis, *clicks);
            result->Success();
        }
        else if (method_call.method_name().compare("keyUp") == 0)
        {
            const auto *key = std::get_if<int>(method_call.arguments());
            automator::KeyboardAPI::keyUp((WORD)*key);
            result->Success();
        }
        else if (method_call.method_name().compare("keyDown") == 0)
        {
            const auto *key = std::get_if<int>(method_call.arguments());
            automator::KeyboardAPI::keyDown((WORD)*key);
            result->Success();
        }
        else if (method_call.method_name().compare("press") == 0)
        {

            const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
            assert(arguments);
            // auto *isShiftKey = std::get_if<bool>(&(arguments->find(flutter::EncodableValue("isShiftKey"))->second));
            auto *key = std::get_if<int>(&(arguments->find(flutter::EncodableValue("key"))->second));
            auto *interval = std::get_if<int>(&(arguments->find(flutter::EncodableValue("interval"))->second));
            auto *times = std::get_if<int>(&(arguments->find(flutter::EncodableValue("times"))->second));

            automator::KeyboardAPI::press((WORD)*key, *times, *interval);
            result->Success();
        }
        else if (method_call.method_name().compare("write") == 0)
        {

            const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
            assert(arguments);

            auto *text = std::get_if<std::string>(&(arguments->find(flutter::EncodableValue("text"))->second));
            auto *interval = std::get_if<int>(&(arguments->find(flutter::EncodableValue("interval"))->second));

            automator::KeyboardAPI::write(*text, *interval);
            result->Success();
        }
        else if (method_call.method_name().compare("hotkey") == 0)
        {

            const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
            assert(arguments);

            auto *keys = std::get_if<flutter::EncodableList>(&(arguments->find(flutter::EncodableValue("keys"))->second));
            auto *interval = std::get_if<int>(&(arguments->find(flutter::EncodableValue("interval"))->second));

            std::list<WORD> hotkeys;
            for (flutter::EncodableValue key : *keys)
            {
                hotkeys.push_back((WORD)*std::get_if<int>(&key));
            }
            automator::KeyboardAPI::hotkey(hotkeys, *interval);

            result->Success();
        }
        else if (method_call.method_name().compare("convertCharacter") == 0)
        {
            const auto *character = std::get_if<std::string>(method_call.arguments());

            SHORT converted = Utils::convertCharacter(character->at(0));

            result->Success(flutter::EncodableValue(converted));
        }
        else
        {
            result->NotImplemented();
        }
    }

} // namespace flutter_auto_gui_windows
