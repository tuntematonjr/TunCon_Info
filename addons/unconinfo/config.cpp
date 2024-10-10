#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {MAIN_ADDON_STR, "ace_medical_feedback", "ace_medical", "ace_medical_status", "ace_common"};
        author = "Tuntematon";
        authorUrl = GITHUBLINK;
        //VERSION_CONFIG;
    };
};

// configs go here
#include "CfgEventHandlers.hpp"