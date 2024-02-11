#include <JustEnoughMod.hpp>

using namespace JEM;

class CorePlugin : public Plugin
{
public:
    virtual std::string getPluginName()
    {
        return "JustEnoughModCore";
    }
    virtual Version getPluginVersion()
    {
        return {0, 0, 0};
    }

    virtual void init()
    {
    }
    virtual void update()
    {
    }
};

JEM_PLUGIN_DEF(CorePlugin)