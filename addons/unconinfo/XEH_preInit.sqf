#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;

private _category = ["Tun Utilities - Uncon Info", "Uncon Info"];

[
    QGVAR(enableUnconInfo),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableUnconInfo", localize "STR_TunCon_CBA_enableUnconInfoTooltip"],
    _category,
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowEpinephrine),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowEpinephrine", localize "STR_TunCon_CBA_enableShowEpinephrineTooltip"],
    _category,
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowBleeding),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowBleeding", localize "STR_TunCon_CBA_enableShowBleedingTooltip"],
    _category,
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowCardiacArrest),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowCardiacArrest", localize "STR_TunCon_CBA_enableShowCardiacArrestTooltip"],
    _category,
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowHeartRate),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowHeartRate", localize "STR_TunCon_CBA_enableShowHeartRateTooltip"],
    _category,
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowStableVitals),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowStableVitals", localize "STR_TunCon_CBA_enableShowStableVitalsTooltip"],
    _category,
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableShowIfTreated),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowIfTreated", localize "STR_TunCon_CBA_enableShowIfTreatedTooltip"],
    _category,
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowNearestUnit),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowingNearestUnit", localize "STR_TunCon_CBA_enableShowingNearestUnitTooltip"],
    _category,
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowNearestUnitDistanceShown),
    "CHECKBOX",
    [localize "STR_TunCon_CBA_enableShowingDistance", localize "STR_TunCon_CBA_enableShowingDistanceTooltip"],
    _category,
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(unconInfoNearestUnitDistance), 
    "SLIDER", 
    [localize "STR_TunCon_CBA_distanceToLookFriendlies", localize "STR_TunCon_CBA_distanceToLookFriendliesTooltip"], 
    _category,
    [10, 100, 50, 0],
    1,
    { 
        params ["_value"];
        _value = round _value;
        GVAR(unconInfoNearestUnitDistance) = _value; 
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(noFriendliesNearbyText), 
    "EDITBOX", 
    [localize "STR_TunCon_CBA_noFriends", localize "STR_TunCon_CBA_noFriendsTooltip"], 
    _category,
    "Your current situation is not looking very good, you could wait or feel free to just press Esc -> Respawn.",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(updateInterval), 
    "SLIDER", 
    [localize "STR_TunCon_CBA_updateInterval", localize "STR_TunCon_CBA_updateIntervalTooltip"], 
    _category,
    [1, 60, 5, 0],
    1,
    { 
        params ["_value"];
        _value = round _value;
        GVAR(updateInterval) = _value; 
    },
    true
] call CBA_Settings_fnc_init;