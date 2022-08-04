#include <windows.h>
#include <string>
#include <list>
#include <flutter/standard_method_codec.h>
#include "flutter_auto_gui_windows_keyboard.h"
#include <iostream>

#include "../utils.h"
#include "../mouse/flutter_auto_gui_windows_mouse.h"
namespace automator
{
    void KeyboardAPI::write(std::string text, int interval)
    {
        for (int i = 0; i < text.length(); i++)
        {
            SHORT key = Utils::convertCharacter(text[i]);
            KeyboardAPI::press(key, 1, interval);
            if (MouseAPI::failSafeTriggered())
            {
                break;
            }
        }
    }
    void KeyboardAPI::keyUp(WORD key)
    {
        const UINT scanCode = MapVirtualKey(LOBYTE(key), 0);
        std::list<KEYBDINPUT> keyboardInputs;
        KEYBDINPUT input;
        ZeroMemory(&input, sizeof(input));

        // current key up
        ZeroMemory(&input, sizeof(input));
        input.wScan = (WORD)scanCode;
        input.dwFlags = KEYEVENTF_SCANCODE | KEYEVENTF_KEYUP;
        keyboardInputs.push_back(input);
        KeyboardAPI::executeKeyboardEvent(keyboardInputs);
    }

    void KeyboardAPI::keyDown(WORD key)
    {
        const UINT scanCode = MapVirtualKey(LOBYTE(key), 0);
        std::list<KEYBDINPUT> keyboardInputs;
        KEYBDINPUT input;
        ZeroMemory(&input, sizeof(input));

        if (key & 0x100)
        {
            // shift down input
            input.wScan = (WORD)MapVirtualKey(VK_LSHIFT, 0);
            input.dwFlags = KEYEVENTF_SCANCODE;
            keyboardInputs.push_back(input);

            // current key down
            ZeroMemory(&input, sizeof(input));
            input.wScan = (WORD)scanCode;
            input.dwFlags = KEYEVENTF_SCANCODE;
            keyboardInputs.push_back(input);

            // shift up input
            ZeroMemory(&input, sizeof(input));
            input.wScan = (WORD)MapVirtualKey(VK_LSHIFT, 0);
            input.dwFlags = KEYEVENTF_SCANCODE | KEYEVENTF_KEYUP;
            keyboardInputs.push_back(input);
        }
        else
        {
            // current key down
            ZeroMemory(&input, sizeof(input));
            input.wScan = (WORD)scanCode;
            input.dwFlags = KEYEVENTF_SCANCODE;
            keyboardInputs.push_back(input);
        }

        KeyboardAPI::executeKeyboardEvent(keyboardInputs);
    }

    void KeyboardAPI::press(WORD key, int times, int interval)
    {
        for (int i = 0; i < times; i++)
        {
            KeyboardAPI::keyDown(key);
            KeyboardAPI::keyUp(key);
            Utils::sleep(interval);
            if (MouseAPI::failSafeTriggered())
            {
                break;
            }
        }
    }

    // private
    void KeyboardAPI::executeKeyboardEvent(KEYBDINPUT keyboardInput)
    {
        INPUT input;
        ZeroMemory(&input, sizeof(input));
        input.type = INPUT_KEYBOARD;
        input.ki = keyboardInput;
        SendInput(1, &input, sizeof(input));
    }
    void KeyboardAPI::executeKeyboardEvent(std::list<KEYBDINPUT> keyboardInputs)
    {
        std::vector<INPUT> input(keyboardInputs.size());
        ZeroMemory(&input[0], input.size() * sizeof(INPUT));

        int index = 0;
        for (const auto &keyboardInput : keyboardInputs)
        {
            input[index].type = INPUT_KEYBOARD;
            input[index].ki = keyboardInput;
            index++;
        }

        SendInput(index + 1, &input[0], sizeof(INPUT));
    }

};
