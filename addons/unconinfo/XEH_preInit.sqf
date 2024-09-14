#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(enableUnconInfo),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableUnconInfo", localize "STR_TunCon_CBA_enableUnconInfoTooltip"],
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableMoan),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableMoan", localize "STR_TunCon_CBA_enableMoanTooltip"],
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowEpinephrine),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowEpinephrine", localize "STR_TunCon_CBA_enableShowEpinephrineTooltip"],
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowBleeding),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowBleeding", localize "STR_TunCon_CBA_enableShowBleedingTooltip"],
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowCardiacArrest),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowCardiacArrest", localize "STR_TunCon_CBA_enableShowCardiacArrestTooltip"],
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowHeartRate),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowHeartRate", localize "STR_TunCon_CBA_enableShowHeartRateTooltip"],
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowStableVitals),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowStableVitals", localize "STR_TunCon_CBA_enableShowStableVitalsTooltip"],
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowIfTreated),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowIfTreated", localize "STR_TunCon_CBA_enableShowIfTreatedTooltip"],
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowDetailedTreatment),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowDetailedTreatment", localize "STR_TunCon_CBA_enableShowDetailedTreatmentTooltip"],
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowIfTreatedConcious),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowIfTreatedConcious", localize "STR_TunCon_CBA_enableShowIfTreatedConciousTooltip"],
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowNearestUnit),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowingNearestUnit", localize "STR_TunCon_CBA_enableShowingNearestUnitTooltip"],
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowNearestUnitDistanceShown),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowingDistance", localize "STR_TunCon_CBA_enableShowingDistanceTooltip"],
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(unconinfoNearestUnitDistance), 
    "SLIDER", 
    [localize "STR_TunCon_CBA_distanceToLookFriendlies", localize "STR_TunCon_CBA_distanceToLookFriendliesTooltip"], 
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    [10, 100, 50, 0],
    1,
    { 
        params ["_value"];
        _value = round _value;
        GVAR(unconinfoNearestUnitDistance) = _value; 
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(noFriendliesNearbyText), 
    "EDITBOX", 
    [localize "STR_TunCon_CBA_noFriends", localize "STR_TunCon_CBA_noFriendsTooltip"], 
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    "Your current situation is not looking very good, you could wait or feel free to just press Esc -> Respawn.",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(updateInterval), 
    "SLIDER", 
    [localize "STR_TunCon_CBA_updateInterval", localize "STR_TunCon_CBA_updateIntervalTooltip"], 
    ["Tun Utilities - Uncon Info", "Uncon Info"],
    [1, 60, 5, 0],
    1,
    { 
        params ["_value"];
        _value = round _value;
        GVAR(updateInterval) = _value; 
    },
    true
] call CBA_Settings_fnc_init;

ADDON = true;