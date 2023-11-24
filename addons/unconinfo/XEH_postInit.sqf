#include "script_component.hpp"

//The purkkaviritys to hide text when opening zeus interface
["ModuleCurator_F", "InitPost", { 
	params ["_entity"];

	_entity addEventHandler ["CuratorObjectRegistered", {
		params ["_curator", "_input"];
		private _player = getAssignedCuratorUnit _curator;
		[] remoteExecCall [QFUNC(hideMessage), _player, false];
	}];
},true, [], true] call CBA_fnc_addClassEventHandler;