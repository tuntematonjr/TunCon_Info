/*
 * Author: 
 * 
 * 
 * [Description]
 * place holder until ace update
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tuncon_unconInfo_fnc_moan
 */
#include "script_component.hpp"
params [["_unit", objNull, [objNull]]];

LOG("Start Moan");
// Check delay between sounds
if (_unit getVariable [QGVAR(delayTime_moan), -1] > CBA_missionTime) exitWith {LOG("Exit moan. Too soon")};
private _delayTime = (floor random 30) + 10;
_unit setVariable [QGVAR(delayTime_moan), (CBA_missionTime + _delayTime)];

// Get units speaker
private _speaker = speaker _unit;
if (_speaker == "ACE_NoVoice") then {
    _speaker = _unit getVariable "ace_originalSpeaker";
};

// Fallback if speaker has no associated scream/moan sound
if (isNull (configFile >> "CfgSounds" >> format ["ACE_moan_%1_low_1", _speaker])) then {
    _speaker = "Male08ENG";
};

// Select actual sound
private _variation = selectRandom ["low", "mid", "high"];

private _cfgSounds = configFile >> "CfgSounds";
private _targetClass = format ["ACE_moan_%1_%2_", _speaker, _variation];
private _index = 1;
private _sounds = [];

while {isClass (_cfgSounds >> (_targetClass + str _index))} do {
    _sounds pushBack (_cfgSounds >> (_targetClass + str _index));
    INC(_index);
};

private _sound = configName selectRandom _sounds;
if (isNil "_sound") exitWith {};

private _distance = random [10, 25, 40];
private _players = allPlayers inAreaArray [ASLToAGL getPosASL _unit, _distance + 5, _distance + 5, 0, true, _distance + 5];
[_unit,[_sound, _distance]] remoteExecCall ["say3D", _players];
