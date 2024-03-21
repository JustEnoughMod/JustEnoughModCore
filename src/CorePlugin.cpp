#include <JustEnoughMod.hpp>

using namespace JEM;

class CorePlugin : public Plugin::Plugin {
  public:
    [[nodiscard]] constexpr auto getPluginName() -> const char * override {
      return "JustEnoughModCore";
    }

    [[nodiscard]] constexpr auto getPluginVersion() -> Version override {
#ifdef VERSION
      return Version(VERSION);
#else
      return Version("0.0.0");
#endif
    }

    void init() override {}

    void update() override {}
};

JEM_PLUGIN_DEF(CorePlugin)
