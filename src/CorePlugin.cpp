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

std::shared_ptr<Plugin> _createPlugin()
{
    return std::shared_ptr<Plugin>(new CorePlugin());
}