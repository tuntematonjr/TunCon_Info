#include "script_component.hpp"
#include "XEH_prep.sqf"

private _category = ["Tun Utilities - Uncon Info", "Uncon Info"];

[
    QGVAR(allowUnconInfo),
    "CHECKBOX",
    ["Enable uncon info", "Enanbles uncon to know whats going around them. Own vitals and if friendlies nearby."],
    _category,
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowNearestUnit),
    "CHECKBOX",
    ["Enable showing nearest unit", "Enanbles uncon to know whats going around them. Own vitals and if friendlies nearby."],
    _category,
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowNearestUnitDistanceShown),
    "CHECKBOX",
    ["Enable showing nearest unit distance", "Enable showing colsest friendlies distance"],
    _category,
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(unconInfoNearestUnitDistance), 
    "SLIDER", 
    ["Distance for looking closest friendly", "Distance in meters to find nearest fiendly and medic"], 
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
    ["Text if no friendlies nearby and no vitals", "Text what is shown when player has bad vitals and no friendlies nearby"], 
    _category,
    "Your current sitsuation is not looking very good, you can try and wait or feel free to just press Esc -> Respawn.",
    1,
    {},
    true
] call CBA_Settings_fnc_init;