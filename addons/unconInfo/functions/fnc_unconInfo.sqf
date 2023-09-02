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

private _text ="You sense that<br/>";
private _bleeding = player getvariable ["ace_medical_woundBleeding", 0];
if (_bleeding > 0) then {
	_text = _text + "You are bleeding<br/>";
};

if (player getvariable ["ace_medical_heartRate", 0] > 0) then {
	_text = _text + "You still have pulse<br/>";
};

if (player getvariable ["ace_medical_inCardiacArrest", false]) then {
	_text = _text + "You are in cardiac arrest<br/>";
};

private _hasStableVitals = [player] call ace_medical_status_fnc_hasStableVitals;
if (_hasStableVitals) then {
	_text = _text + "You have stable vitals (you can wake up)<br/>";
} else {
	_text = _text + "You don't have stable vitals (you can't wake up)<br/>";
};

if ([player, "Epinephrine"] call ace_medical_status_fnc_getMedicationCount > 0) then {
	_text = _text + "You have epipherine in your system (huge increase on waking up)<br/>";
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
					_text = format["%1Closest unit is %2 and is also medic (%3m)",_text, name _closestUnit,  _closestUnitDistance];
				} else {
					_text = format["%1Closest unit is %2 and is also medic",_text, name _closestUnit];
				};
			} else {
				if (_nearestUnitDistanceAllowed) then {
					_text = format["%1Closest unit is %2 (%3m)<br/>Closest medic is %4 (%5m)",_text, name _closestUnit,  _closestUnitDistance, name _closestMedic,  _closestMedicDistance];
				} else {
					_text = format["%1Closest unit is %2<br/>Closest medic is %3",_text, name _closestUnit, name _closestMedic];
				};
			};
		} else {
			if (_nearestUnitDistanceAllowed) then {
				_text = format["%1Closest unit is %2 (%3m), but no medics nearby",_text, name _closestUnit,  _closestUnitDistance];
			} else {
				_text = format["%1Closest unit is %2, but no medics nearby",_text, name _closestUnit];
			};
		};
	} else {
		_text = _text + "There are no friendlies nearby";

		if (_bleeding > 0 && !(_hasStableVitals)) then {
			_text = _text + "<br/>"+ GVAR(noFriendliesNearbyText);
		};
	};
};

cutText ["<t size='2'>"+_text+"</t>", "PLAIN NOFADE" , -1, false, true];