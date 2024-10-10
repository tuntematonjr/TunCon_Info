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
	false
] call CBA_fnc_addSetting;

[
	QGVAR(enableMoan),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableMoan", localize "STR_TunCon_CBA_enableMoanTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(enableShowEpinephrine),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableShowEpinephrine", localize "STR_TunCon_CBA_enableShowEpinephrineTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(enableShowBleeding),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableShowBleeding", localize "STR_TunCon_CBA_enableShowBleedingTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(enableShowCardiacArrest),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableShowCardiacArrest", localize "STR_TunCon_CBA_enableShowCardiacArrestTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(enableShowHeartRate),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableShowHeartRate", localize "STR_TunCon_CBA_enableShowHeartRateTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(enableShowStableVitals),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableShowStableVitals", localize "STR_TunCon_CBA_enableShowStableVitalsTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(enableShowIfTreated),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableShowIfTreated", localize "STR_TunCon_CBA_enableShowIfTreatedTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(enableShowDetailedTreatment),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableShowDetailedTreatment", localize "STR_TunCon_CBA_enableShowDetailedTreatmentTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(enableShowIfTreatedConcious),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableShowIfTreatedConcious", localize "STR_TunCon_CBA_enableShowIfTreatedConciousTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(allowNearestUnit),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableShowingNearestUnit", localize "STR_TunCon_CBA_enableShowingNearestUnitTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(allowNearestUnitDistanceShown),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableShowingDistance", localize "STR_TunCon_CBA_enableShowingDistanceTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(enableShowIsInVehicle),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableShowIsInVehicle", localize "STR_TunCon_CBA_enableShowIsInVehicleTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(enableShowIsOthersInVehicle),
	"CHECKBOX",
	[localize "STR_TunCon_CBA_enableShowIsInVehicleOthers", localize "STR_TunCon_CBA_enableShowIsInVehicleOthersTooltip"],
	["Tun Utilities - Uncon Info", "Uncon Info"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;

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
	false
] call CBA_fnc_addSetting;

[
	QGVAR(noFriendliesNearbyText), 
	"EDITBOX", 
	[localize "STR_TunCon_CBA_noFriends", localize "STR_TunCon_CBA_noFriendsTooltip"], 
	["Tun Utilities - Uncon Info", "Uncon Info"],
	"Your current situation is not looking very good, you could wait or feel free to just press Esc -> Respawn.",
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(updateInterval), 
	"TIME", 
	[localize "STR_TunCon_CBA_updateInterval", localize "STR_TunCon_CBA_updateIntervalTooltip"], 
	["Tun Utilities - Uncon Info", "Uncon Info"],
	[1, 60, 1, 0],
	1,
	{ 
		params ["_value"];
		_value = round _value;
		GVAR(updateInterval) = _value; 
	},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(detailedTreatmentDelay), 
	"TIME", 
	[localize "STR_TunCon_CBA_detailedTreatmentDelay", localize "STR_TunCon_CBA_detailedTreatmentDelayTooltip"], 
	["Tun Utilities - Uncon Info", "Uncon Info"],
	[0, 60, 0, 0],
	1,
	{ 
		params ["_value"];
		_value = round _value;
		GVAR(detailedTreatmentDelay) = _value; 
	},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(delayForUnconInfoTexts), 
	"TIME", 
	[localize "STR_TunCon_CBA_delayForUnconInfoTexts", localize "STR_TunCon_CBA_delayForUnconInfoTextsTooltip"], 
	["Tun Utilities - Uncon Info", "Uncon Info"],
	[0, 60, 5, 0],
	1,
	{ 
		params ["_value"];
		_value = round _value;
        GVAR(delayForUnconInfoTexts) = _value; 
    },
    false
] call CBA_fnc_addSetting;

ADDON = true;