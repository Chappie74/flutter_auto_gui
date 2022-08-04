#include <windows.h>
#include <string>
#include <list>
#include <chrono>
#include <thread>
#include <flutter/standard_method_codec.h>
#include "mouse/flutter_auto_gui_windows_mouse.h"
namespace Utils
{

    std::list<POINT> parsePointsList(flutter::EncodableList list)
    {
        std::list<POINT> pointsList;
        for (flutter::EncodableValue step : list)
        {
            // get the map of each step
            const auto *stepMap = std::get_if<flutter::EncodableMap>(&step);

            POINT p;
            // get the x coordinate from the map
            p.x = *std::get_if<int>(&(stepMap->find(flutter::EncodableValue("x"))->second));
            // get the y coordinate from the map
            p.y = *std::get_if<int>(&(stepMap->find(flutter::EncodableValue("y"))->second));
            pointsList.push_back(p);
        }
        return pointsList;
    }

    DWORD convertMouseButton(std::string button, bool isInUpState)
    {
        if (button.find(automator::MouseAPI::LEFT) != std::string::npos)
        {
            return isInUpState ? MOUSEEVENTF_LEFTUP : MOUSEEVENTF_LEFTDOWN;
        }
        else if (button.find(automator::MouseAPI::RIGHT) != std::string::npos)
        {
            return isInUpState ? MOUSEEVENTF_RIGHTUP : MOUSEEVENTF_RIGHTDOWN;
        }
        else if (button.find(automator::MouseAPI::MIDDLE) != std::string::npos)
        {
            return isInUpState ? MOUSEEVENTF_MIDDLEUP : MOUSEEVENTF_MIDDLEDOWN;
        }
        else
        {
            return isInUpState ? MOUSEEVENTF_LEFTUP : MOUSEEVENTF_LEFTDOWN;
        }
    }

    DWORD convertAxis(std::string axis)
    {
        if (axis.find(automator::MouseAPI::H_AXIS) != std::string::npos)
        {
            return MOUSEEVENTF_HWHEEL;
        }
        else
        {
            return MOUSEEVENTF_WHEEL;
        }
    }

    void sleep(int duration)
    {
        std::this_thread::sleep_for(std::chrono::milliseconds(duration));
    }

    SHORT convertCharacter(CHAR ch)
    {
        HKL kbl = GetKeyboardLayout(0);
        SHORT vk = VkKeyScanEx(ch, kbl);
        return vk;
    }

}