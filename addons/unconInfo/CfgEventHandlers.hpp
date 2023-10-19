class Extended_PostInit_EventHandlers {
    class Tun_unconInfo {
        clientInit = QUOTE(call COMPILE_FILE(XEH_clientInit));
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_PreInit_EventHandlers {
    class Tun_unconInfo {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};