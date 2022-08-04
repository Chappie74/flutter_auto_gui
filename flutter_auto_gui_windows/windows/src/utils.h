#include <windows.h>
#include <list>
#include <flutter/standard_method_codec.h>
namespace Utils
{

    std::list<POINT> parsePointsList(flutter::EncodableList list);
    DWORD convertMouseButton(std::string button, bool isInUpState);
    DWORD convertAxis(std::string axis);
    SHORT convertCharacter(CHAR ch);
    void sleep(int duration);
}