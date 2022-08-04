#include <windows.h>
#include <string>
#include <list>
#include <flutter/standard_method_codec.h>
namespace automator
{

    class MouseAPI
    {
    public:
        // Constant strings for mouse buttons
        static const std::string LEFT;
        static const std::string RIGHT;
        static const std::string MIDDLE;
        static const std::string H_AXIS;
        static const std::string V_AXIS;
        // static const std::string PRIMARY;
        // static const std::string SECONDARY;

        // Mouse Event Methods
        static POINT position();
        static void move(std::list<POINT> steps, int sleep);
        static void drag(std::list<POINT> steps, int sleep, std::string button);
        static void mouseDown(std::string button);
        static void mouseUp(std::string button);
        static void click(std::string button, int clicks, int interval);
        static void scroll(std::string axis, int clicks);
        static bool MouseAPI::failSafeTriggered();

    private:
        static void executeMouseEvent(MOUSEINPUT input);
    };
};
