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
    // Presses the corresponding key for each letter in [text] with [interval] delay
    // between each press
    void KeyboardAPI::write(std::string text, int interval)
    {

        for (int i = 0; i < text.length(); i++)
        {
            // convert character to it's virtual code
            SHORT key = Utils::convertCharacter(text[i]);
            KeyboardAPI::press(key, 1, interval);
            if (MouseAPI::failSafeTriggered())
            {
                break;
            }
        }
    }

    // Sets the [key] to Up position
    void KeyboardAPI::keyUp(WORD key)
    {
        // converts the virtual keycode to scan code
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

    // Sets the [key] to Down position
    void KeyboardAPI::keyDown(WORD key)
    {
        // converts the virtual keycode to scan code
        const UINT scanCode = MapVirtualKey(LOBYTE(key), 0);
        std::list<KEYBDINPUT> keyboardInputs;
        KEYBDINPUT input;
        ZeroMemory(&input, sizeof(input));

        // check high order byte to see if shift key is pressed (for upper case letters)
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

    // Sets a [key] to Down then Up position for a given amount of [time]
    // with [interval] delay between each action
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

    // Sets a [key] to Down then Up position for a given amount of [time]
    // with [interval] delay between each action
    void KeyboardAPI::hotkey(std::list<WORD> keys, int interval)
    {
        // Create iterator pointing to first element
        std::list<WORD>::iterator keysIterator;
        for (keysIterator = keys.begin(); keysIterator != keys.end(); keysIterator++)
        {
            // sets all the keys in the down position one after the other
            KeyboardAPI::keyDown(*keysIterator);
            Utils::sleep(interval);
            if (MouseAPI::failSafeTriggered())
            {
                break;
            }
        }

        std::list<WORD>::reverse_iterator keysReverseIterator;
        // set all keys in reverse order to up position
        for (keysReverseIterator = keys.rbegin(); keysReverseIterator != keys.rend(); ++keysReverseIterator)
        {
            std::cout << *keysReverseIterator;
            // sets all the keys in the up position one after the other
            KeyboardAPI::keyUp(*keysReverseIterator);
            if (MouseAPI::failSafeTriggered())
            {
                break;
            }
        }
    }

    // private

    // General function to execute send input keyboard events ()
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
