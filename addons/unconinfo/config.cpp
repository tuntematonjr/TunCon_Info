#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
    class Tun_unconInfo {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_xeh","cba_settings", "ace_main", "TunCon_main"};
        author = "Tuntematon";
        authorUrl = "https://github.com/tuntematonjr/Tun-Utilities";
    };
};

// configs go here
#include "CfgEventHandlers.hpp"