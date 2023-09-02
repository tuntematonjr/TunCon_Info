#include "script_component.hpp"

if (hasInterface) then {
	//Add uncon info EH
	private _id = ["ace_unconscious", {
		_this params ["_unit", "_state"];
		if ( _state &&  _unit isEqualTo player && GVAR(allowUnconInfo)) then {
			_handle = [{
				if (!(player getVariable ["ACE_isUnconscious", false]) || {!alive player}) exitWith {
					cutText ["", "PLAIN NOFADE", -1, false, true];
					[_handle] call CBA_fnc_removePerFrameHandler; 
				};

				[] call FUNC(unconInfo);

			}, 5] call CBA_fnc_addPerFrameHandler;
		};
	}] call CBA_fnc_addEventHandler;
};