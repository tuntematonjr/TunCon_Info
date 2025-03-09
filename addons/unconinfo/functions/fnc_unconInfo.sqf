/*
 * Author: [Tuntematon]
 * [Description]
 * 
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tuncon_unconinfo_fnc_unconinfo
 */
#include "script_component.hpp"

#define TEXTSIZE_NORMAL	"1.75"
#define TEXTSIZE_SMALL	"1.25"


private _text = localize "STR_TunCon_firstLine" + "<br/>";
private _bleeding = ace_player getVariable ["ace_medical_woundBleeding", 0];
private _hasStableVitals = [ace_player] call ace_medical_status_fnc_hasStableVitals;
private _drugs = [ace_player] call ace_medical_status_fnc_getAllMedicationCount;
private _hasEpi = false;
// private _hasMorphine = false;
// private _hasPils = false;

{
	_x params ["_name"];

	if (_name == "epinephrine") then {_hasEpi = true;};
	// switch (toLower _name) do {
	// 	case ("epinephrine"): {_hasEpi = true;};
	// 	case ("morphine"): {_hasMorphine = true;};
	// 	case ("painkillers"): {_hasPils = true;};
	// 	default {};
	// };
} forEach _drugs;

if (GVAR(enableShowBleeding) && _bleeding > 0) then {
	_text = _text + localize "STR_TunCon_isBleeding" + "<br/>";
};

//Heart rate/
if (ace_player getVariable ["ace_medical_inCardiacArrest", false]) then {
	if (GVAR(enableShowCardiacArrest)) then {
		_text = _text + localize "STR_TunCon_inCardiacArrest" + "<br/>";
	};
} else {
	if (GVAR(enableShowHeartRate) && {ace_player getVariable ["ace_medical_heartRate", 0] > 0}) then {
		_text = _text + localize "STR_TunCon_hasPulse" + "<br/>";
	};

	if (_hasStableVitals) then {
		if (GVAR(enableShowStableVitals)) then {
			_text = _text + localize "STR_TunCon_hasStableVitals" + "<br/>";
		};

		if (GVAR(enableShowEpinephrine) && {_hasEpi}) then {
			_text = _text + localize "STR_TunCon_hasepinEphrine" + "<br/>";
		};
	} else {
		if (GVAR(enableShowStableVitals)) then {
			_text = _text + localize "STR_TunCon_notStableVitals" + "<br/>";
		};
	};
};

if (GVAR(enableShowIsInVehicle)) then {
	private _closestUnitVehicle = vehicle ace_player;
	if (_closestUnitVehicle isNotEqualTo ace_player) then {
		private _vehicleName = _closestUnitVehicle getVariable ["displayName", getText (configOf _closestUnitVehicle >> "displayName")];
		_text = _text + (format[localize "STR_TunCon_insideVehicle", _vehicleName]) + "<br/>";
	};
};

if (GVAR(allowNearestUnit)) then {

	private _distance = GVAR(unconInfoNearestUnitDistance);
	private _pos = ASLToAGL getPosASL ace_player;
	private _nearUnits = ([_pos, _distance, _distance, 0, false] nearEntities [["CAManBase"], false, true, true]) - [ace_player];
	FILTER(_nearUnits,playerSide isEqualTo side _x && [_x] call ace_common_fnc_isAwake && !(unitIsUAV _x));
	private _closestUnit = objNull;
	private _closestMedic = objNull;
	private _closestUnitDistance = _distance;
	private _closestMedicDistance = _distance;
	private _nearestUnitDistanceAllowed = GVAR(allowNearestUnitDistanceShown);
	{
		private _unit = _x;
		private _distance = ace_player distance _unit;
		
		if (_distance <= _closestUnitDistance) then {
			_closestUnit = _unit;
			_closestUnitDistance = round _distance;
		};

		if ([_unit] call ace_common_fnc_isMedic && {_distance <= _closestMedicDistance}) then {
			_closestMedic = _unit;
			_closestMedicDistance = round _distance;
		};
	} forEach _nearUnits;

	if (_closestUnit isNotEqualTo objNull) then {
		private _showInVehicleAllowed = GVAR(enableShowIsOthersInVehicle);
		private _closestUnitVehicle = vehicle _closestUnit;
		private _closestUnitInVehicle = _closestUnitVehicle isNotEqualTo _closestUnit;
		private _closestUnitInVehicleText = "";
		if (_closestUnitInVehicle) then {
			private _vehicleName = _closestUnitVehicle getVariable ["displayName", getText (configOf _closestUnitVehicle >> "displayName")];
			_closestUnitInVehicleText = format [localize "STR_TunCon_isInVehicle", _vehicleName];
		};
		
		if (_closestUnit isEqualTo _closestMedic) then {
			_text = _text + (format [localize "STR_TunCon_closestUnitIsMedic", name _closestUnit]);
			
			if (_closestUnitInVehicle && _showInVehicleAllowed) then {
				_text = _text + " " + _closestUnitInVehicleText;
			};

			if (_nearestUnitDistanceAllowed) then {
				_text = _text + format[" (%1m)", _closestUnitDistance];
			};
		} else {
			private _closestUnitText = (format [localize "STR_TunCon_closestUnit", name _closestUnit]);
			private _closestMedicText = format [localize "STR_TunCon_closestMedic", name _closestMedic];

			if (_closestUnitInVehicle && _showInVehicleAllowed) then {
				_closestUnitText = _closestUnitText + " " + _closestUnitInVehicleText;
			};

			if (_nearestUnitDistanceAllowed) then {
				_closestUnitText = _closestUnitText + format[" (%1m)", _closestUnitDistance];
			};

			if (_closestMedic isEqualTo objNull) then {
				_closestMedicText = localize "STR_TunCon_noMedicsNear";
			} else {
				private _closestMedicVehicle = vehicle _closestMedic;
				private _closestMedicInVehicle = _closestMedicVehicle isNotEqualTo _closestMedic;
				
				if (_closestMedicInVehicle && _showInVehicleAllowed) then {
					private _vehicleName = _closestMedicVehicle getVariable ["displayName", getText (configOf _closestMedicVehicle >> "displayName")];
					_closestMedicText = _closestMedicText + " " + (format [localize "STR_TunCon_isInVehicle", _vehicleName]);
				};

				if (_nearestUnitDistanceAllowed) then {
					_closestMedicText = _closestMedicText + format[" (%1m)", _closestMedicDistance];
				};
			};
			_text = _text + _closestUnitText + "<br/>" + _closestMedicText;
		};
	} else {
		_text = _text + localize "STR_TunCon_noFriends";

		if (_bleeding > 0 && !(_hasStableVitals)) then {
			_text = _text + "<br/>" + GVAR(noFriendliesNearbyText);
		};
	};
};

private _cbaTime = cba_missionTime;
if (GVAR(isBeingHelpedTime) > _cbaTime && !GVAR(enableShowDetailedTreatment)) then {
	_text = _text + "<br/>" + localize "STR_TunCon_isBeingHelpedText";
};

_text = "<t size='"+ TEXTSIZE_NORMAL +"'>"+_text+"</t>";

private _treatmentList = GVAR(treatments);
if (GVAR(enableShowDetailedTreatment) && {_treatmentList isNotEqualTo []} && {((_treatmentList select -1) select 1) + GVAR(detailedTreatmentDelay) <= _cbaTime}) then {
	_text = _text + "<br/>" + "<t size='"+ TEXTSIZE_NORMAL +"'>" + localize "STR_TunCon_treatments"  + "</t>";
	{
		_x params [ "_treatmenText", "_time"];
		if (_time + GVAR(detailedTreatmentDelay) <= _cbaTime) then {
			_text = _text + "<br/>" + "<t size='"+ TEXTSIZE_SMALL+"'>" + format["%1 - %2s",_treatmenText, round(_cbaTime - _time)] + "</t>";
		};
	} forEachReversed _treatmentList;
};

if (_text isEqualTo "<t size='"+ TEXTSIZE_NORMAL +"'>"+(localize "STR_TunCon_firstLine" + "<br/>")+"</t>") then {
	_text = "";
};

QGVAR(cutTextLayer) cutText ["<t valign='top' align='center'>"+_text+"</t>", "PLAIN NOFADE" , -1, false, true];