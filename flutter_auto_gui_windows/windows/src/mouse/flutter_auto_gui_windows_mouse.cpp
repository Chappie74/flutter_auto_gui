#include <windows.h>
#include <string>
#include <chrono>
#include <thread>
#include "flutter_auto_gui_windows_mouse.h"
#include "../utils.h"
namespace automator
{
    const std::string MouseAPI::LEFT = "left";
    const std::string MouseAPI::RIGHT = "right";
    const std::string MouseAPI::MIDDLE = "middle";
    const std::string MouseAPI::H_AXIS = "horizontal";
    const std::string MouseAPI::V_AXIS = "vertical";
    // const std::string MouseAPI::PRIMARY = "primary";
    // const std::string MouseAPI::SECONDARY = "secondary";

    POINT MouseAPI::position()
    {
        POINT p;
        GetCursorPos(&p);
        return p;
    }

    void MouseAPI::move(std::list<POINT> steps, int sleep)
    {
        for (POINT p : steps)
        {
            if (failSafeTriggered())
            {
                break;
            }
            MOUSEINPUT input;
            ZeroMemory(&input, sizeof(input));
            input.dx = p.x * (65536 / GetSystemMetrics(SM_CXVIRTUALSCREEN));
            input.dy = p.y * (65536 / GetSystemMetrics(SM_CYVIRTUALSCREEN));
            input.dwFlags = MOUSEEVENTF_MOVE | MOUSEEVENTF_VIRTUALDESK | MOUSEEVENTF_ABSOLUTE;
            MouseAPI::executeMouseEvent(input);
            Utils::sleep(sleep);
        }
    }

    void MouseAPI::drag(std::list<POINT> steps, int sleep, std::string button)
    {
        // mouseDown(button);
        // Utils::sleep(10);
        DWORD mouseButton = Utils::convertMouseButton(button, false);
        for (POINT p : steps)
        {
            if (failSafeTriggered())
                break;

            MOUSEINPUT input;
            ZeroMemory(&input, sizeof(input));
            input.dx = p.x * (65536 / GetSystemMetrics(SM_CXVIRTUALSCREEN));
            input.dy = p.y * (65536 / GetSystemMetrics(SM_CYVIRTUALSCREEN));
            input.dwFlags = MOUSEEVENTF_MOVE | MOUSEEVENTF_VIRTUALDESK | MOUSEEVENTF_ABSOLUTE | mouseButton;
            MouseAPI::executeMouseEvent(input);
            std::this_thread::sleep_for(std::chrono::milliseconds(sleep));
        }
        mouseUp(button);
    }

    void MouseAPI::mouseDown(std::string button)
    {

        MOUSEINPUT input;
        ZeroMemory(&input, sizeof(input));
        input.dwFlags = Utils::convertMouseButton(button, false);
        executeMouseEvent(input);
    }

    void MouseAPI::mouseUp(std::string button)
    {
        MOUSEINPUT input;
        ZeroMemory(&input, sizeof(input));
        input.dwFlags = input.dwFlags = Utils::convertMouseButton(button, true);
        executeMouseEvent(input);
    }

    void MouseAPI::click(std::string button, int clicks, int interval)
    {
        for (int i = 0; i < clicks; i++)
        {
            if (failSafeTriggered())
                break;
            mouseDown(button);
            mouseUp(button);
            Utils::sleep(interval);
        }
    }

    void MouseAPI::scroll(std::string axis, int clicks)
    {
        MOUSEINPUT input;
        ZeroMemory(&input, sizeof(input));
        input.dwFlags = Utils::convertAxis(axis);
        input.mouseData = WHEEL_DELTA * clicks;
        executeMouseEvent(input);
    }

    bool MouseAPI::failSafeTriggered()
    {
        POINT p = position();
        return (p.x == 0 && p.y == 0);
    }

    // private
    void MouseAPI::executeMouseEvent(MOUSEINPUT mouseInput)
    {
        INPUT input;
        ZeroMemory(&input, sizeof(input));
        input.type = INPUT_MOUSE;
        input.mi = mouseInput;
        SendInput(1, &input, sizeof(input));
    }

}
