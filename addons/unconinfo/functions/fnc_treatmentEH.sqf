/*
 * Author: [Tuntematon]
 * Handles ACE medical treatment events and displays messages
 *
 * Arguments:
 * 0: Event type <NUMBER>
 * 1: Medic <OBJECT>
 * 2: Patient <OBJECT>
 * 3: Body part <STRING>
 * 4: Treatment class <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [1, medic, patient, "Head", "BasicBandage"] call tunuti_unconinfo_fnc_treatmentEH
 */

#include "script_component.hpp"

params [["_event", 0, [1]], ["_medic", objNull, [objNull]], ["_patient", objNull, [objNull]], ["_bodyPart", "", [""]], ["_classname", "", [""]]];
private _player = player;
if (_medic isEqualTo _patient || _player isNotEqualTo _patient) exitWith {};

private _config = configFile >> "ACE_Medical_Treatment_Actions" >> _classname;
private _displayName = toLower (getText (_config >> "displayName"));
private _displayNameProgress = toLower (getText (_config >> "displayNameProgress") trim [".",0]);

_medic = name _medic;
private _isUncon = lifeState _player == "INCAPACITATED" && GVAR(enableShowIfTreated);

private _text = switch (_event) do {
	case 1: {
		format[localize "STR_TunCon_EH_startedTreatment", _medic, _displayNameProgress, _bodyPart]
	};

	case 2: {
		private _textToFormat = localize(["STR_TunCon_EH_succededTreatment", "STR_TunCon_EH_succededTreatmentStructured"] select _isUncon);
		format[_textToFormat, _medic, _displayName, _bodyPart]
	};

	case 3: {
		private _textToFormat = localize(["STR_TunCon_EH_failedTreatment", "STR_TunCon_EH_failedTreatmentStructured"] select _isUncon);
		format[_textToFormat, _medic, _displayName, _bodyPart]
	};

	default {"Failed to get treatment"};
};

if _isUncon then {
	GVAR(isBeingHelped) = true;
	if (GVAR(enableShowDetailedTreatment)) then {
		private _treatmentlist = GVAR(treatments);
		GVAR(treatments) pushBack [_text, cba_missionTime];
		//Keep only limited amount
		if (count _treatmentlist > 15) then {
			_treatmentlist deleteAt 0;
		};
	};
} else {
	if (GVAR(enableShowIfTreatedConcious) && !(_player getVariable ["ACE_isUnconscious", false]) && alive _player) then {
		[_text, false, 7] call ace_common_fnc_displayText;
	};
};
