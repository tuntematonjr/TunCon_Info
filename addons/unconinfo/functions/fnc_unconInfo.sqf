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

		if (GVAR(enableShowEpinephrine) && {[ace_player, "Epinephrine"] call ace_medical_status_fnc_getMedicationCount > 0}) then {
			_text = _text + localize "STR_TunCon_hasepinEphrine" + "<br/>";
		};
	} else {
		if (GVAR(enableShowStableVitals)) then {
			_text = _text + localize "STR_TunCon_notStableVitals" + "<br/>";
		};
	};
};

if (GVAR(allowNearestUnit)) then {

	private _distance = GVAR(unconInfoNearestUnitDistance);
	private _nearUnits = (ace_player nearEntities ["CAManBase", _distance]) - [ace_player];
	FILTER(_nearUnits,playerSide isEqualTo side _x);
	private _closestUnit = objNull;
	private _closestMedic = objNull;
	private _closestUnitDistance = _distance;
	private _closestMedicDistance = _distance;
	private _nearestUnitDistanceAllowed = GVAR(allowNearestUnitDistanceShown);
	{
		private _unit = _x;
		private _distance = ace_player distance _unit;
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
if (_treatmentList isNotEqualTo [] && GVAR(enableShowDetailedTreatment)) then {
	_text = _text + "<br/>" + "<t size='"+ TEXTSIZE_NORMAL +"'>" + "Treatments:" + "</t>";
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

cutText ["<t valign='top' align='center'>"+_text+"</t>", "PLAIN NOFADE" , -1, false, true];