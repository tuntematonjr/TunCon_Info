#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tuncon_main"};
        author = "Tuntematon";
        authorUrl = "https://github.com/tuntematonjr/TunCon_Info";
        //VERSION_CONFIG;
    };
};

// configs go here
#include "CfgEventHandlers.hpp"