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
 * [] call tun_unconInfo_fnc_unconInfo
 */
#include "script_component.hpp"

private _text = localize "STR_TunCon_firstLine" + "<br/>";
private _bleeding = player getvariable ["ace_medical_woundBleeding", 0];
private _hasStableVitals = [player] call ace_medical_status_fnc_hasStableVitals;

if (_bleeding > 0) then {
	_text = _text + localize "STR_TunCon_isBleeding" + "<br/>";
};

if (player getvariable ["ace_medical_inCardiacArrest", false]) then {
	_text = _text + localize "STR_TunCon_inCardiacArrest" + "<br/>";
} else {
	if (player getvariable ["ace_medical_heartRate", 0] > 0) then {
		_text = _text + localize "STR_TunCon_hasPulse" + "<br/>";
	};

	if (_hasStableVitals) then {
		_text = _text + localize "STR_TunCon_hasStableVitals" + "<br/>";

		if ([player, "Epinephrine"] call ace_medical_status_fnc_getMedicationCount > 0) then {
			_text = _text + localize "STR_TunCon_hasepinEphrine" + "<br/>";
		};
	} else {
		_text = _text + localize "STR_TunCon_notStableVitals" + "<br/>";
	};
};

if (GVAR(allowNearestUnit)) then {

	private _distance = GVAR(unconInfoNearestUnitDistance);
	private _nearUnits = (player nearEntities ["CAManBase", _distance]) - [player];
	FILTER(_nearUnits, playerside isEqualTo side _x);
	private _closestUnit = objNull;
	private _closestMedic = objNull;
	private _closestUnitDistance = _distance;
	private _closestMedicDistance = _distance;
	private _nearestUnitDistanceAllowed = GVAR(allowNearestUnitDistanceShown);
	{
		private _unit = _x;
		private _distance = player distance _unit;
		if (_distance <= _closestUnitDistance && {!(_unit getVariable ["ACE_isUnconscious", false])}) then {
			_closestUnit = _unit;
			_closestUnitDistance = round _distance;
		};

		if ([_unit] call ace_common_fnc_isMedic && {_distance <= _closestMedicDistance}) then {
			_closestMedic = _unit;
			_closestMedicDistance = round _distance;           
		};
	} forEach _nearUnits;

	if (_closestUnit isNotEqualTo objNull) then {
		if (_closestMedic isNotEqualTo objNull) then {
			if (_closestUnit isEqualTo _closestMedic) then {
				if (_nearestUnitDistanceAllowed) then {
					_text = format [localize "STR_TunCon_closestUnitWithDistance",_text, name _closestUnit,  _closestUnitDistance];
				} else {
					_text = format [localize "STR_TunCon_closestUnitWithOutDistance",_text, name _closestUnit];
				};
			} else {
				if (_nearestUnitDistanceAllowed) then {
					_text = format [localize "STR_TunCon_closestUnitAndMedicWithDistance",_text, name _closestUnit,  _closestUnitDistance, name _closestMedic,  _closestMedicDistance];
				} else {
					_text = format [localize "STR_TunCon_closestUnitAndMedicWithOutDistance",_text, name _closestUnit, name _closestMedic];
				};
			};
		} else {
			if (_nearestUnitDistanceAllowed) then {
				_text = format [localize "STR_TunCon_closestUnitNoMedicWithDistance",_text, name _closestUnit,  _closestUnitDistance];
			} else {
				_text = format [localize "STR_TunCon_closestUnitNoMedicWithOutDistance",_text, name _closestUnit];
			};
		};

		if (GVAR(isBeingHelped)) then {
			GVAR(isBeingHelped) = false;
			_text = _text + "<br/>" + localize "STR_TunCon_isBeingHelpedText";
		};

	} else {
		_text = _text + localize "STR_TunCon_noFriends";

		if (_bleeding > 0 && !(_hasStableVitals)) then {
			_text = _text + "<br/>" + GVAR(noFriendliesNearbyText);
		};
	};
};

cutText ["<t size='2'>"+_text+"</t>", "PLAIN NOFADE" , -1, false, true];