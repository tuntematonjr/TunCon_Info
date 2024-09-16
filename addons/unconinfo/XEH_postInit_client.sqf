#include "script_component.hpp"

//Add uncon info EH
["ace_unconscious", {
	_this params ["_unit", "_state"];
	if ( _state && _unit isEqualTo player && GVAR(enableUnconInfo)) then {
		[{
			GVAR(isBeingHelped) = false;
			GVAR(treatments) = [];

			[{
				private _player = player;
				if (GVAR(isBeingHelped)) then {
					GVAR(isBeingHelpedTime) = cba_missionTime + 20;
					GVAR(isBeingHelped) = false;
				};

				if (!(_player getVariable ["ACE_isUnconscious", false]) || {!alive _player}) exitWith {
					cutText ["", "PLAIN NOFADE", -1, false, true];
					[_handle] call CBA_fnc_removePerFrameHandler; 
				};
				
				if (GVAR(enableMoan)) then {
					[_player] call FUNC(moan);
				};

				//Dont run at curator screen
				if (isNull curatorCamera && _player isEqualTo ace_player) then {
					[] call FUNC(unconInfo);
				};
				
			}, GVAR(updateInterval)] call CBA_fnc_addPerFrameHandler;
		}, [], GVAR(delayForUnconInfoTexts)] call CBA_fnc_waitAndExecute;
	};
}] call CBA_fnc_addEventHandler;

//local events for medic
["ace_treatmentStarted", {
	params ["_medic", "_patient", "_bodyPart", "_classname"];
	[QGVAR(ace_treatmentToPatient), [1, _medic, _patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
}] call CBA_fnc_addEventHandler;

["ace_treatmentSucceded", {
	params ["_medic", "_patient", "_bodyPart", "_classname"];
	[QGVAR(ace_treatmentToPatient), [2, _medic, _patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
}] call CBA_fnc_addEventHandler;

["ace_treatmentFailed", {
	params ["_medic", "_patient", "_bodyPart", "_classname"];
	[QGVAR(ace_treatmentToPatient), [3, _medic, _patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
}] call CBA_fnc_addEventHandler;

//event to transfer local events to patients
[QGVAR(ace_treatmentToPatient), {
	params ["_event", "_medic", "_patient", "_bodyPart", "_classname"];
	[_event, _medic, _patient, toLower _bodyPart, _classname] call FUNC(treatmentEH);
}] call CBA_fnc_addEventHandler;