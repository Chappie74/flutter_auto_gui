#include <windows.h>
#include <string>
#include <list>
#include <flutter/standard_method_codec.h>
namespace automator
{
    class KeyboardAPI
    {
    public:
        static void write(std::string text, int interval = 50);
        static void keyUp(WORD key);
        static void keyDown(WORD key);
        static void press(WORD key, int time = 1, int interval = 50);
        static void hotkey(std::list<WORD> keys, int interval = 50);

    private:
        static void executeKeyboardEvent(std::list<KEYBDINPUT> keyboardInputs);
    };
}