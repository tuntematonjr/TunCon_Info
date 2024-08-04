/*
 * Author: https://github.com/acemod/ACE3/blob/2db56cc4bb691f9eeaeb74945382cc58ca7db14c/addons/medical_feedback/functions/fnc_playInjuredSound.sqf
 * Modified version to work on unconsius.
 * 
 * 
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
 * [] call tuncon_unconinfo_fnc_moan
 */
#include "script_component.hpp"
params [["_unit", objNull, [objNull]], ["_severity", 0, [0]]];

#define TIME_OUT_MOAN [12, 7.5, 5]

//if (!local _unit) exitWith { ERROR_2("playInjuredSound: Unit not local or null [%1:%2]",_unit,typeOf _unit); };

// Limit network traffic by only sending the event to players who can potentially hear it
private _distance = [10, 20, 40] select _severity;

private _targets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, _distance, _distance, 0, false, _distance];
if (_targets isEqualTo []) exitWith {};

// Handle timeout
if (_unit getVariable [QGVAR(soundTimeout_moan), -1] > CBA_missionTime) exitWith {};
private _timeOut = TIME_OUT_MOAN # _severity;
//_unit setVariable [QGVAR(soundTimeout_moan), CBA_missionTime + _timeOut];

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
private _variation = ["low", "mid", "high"] select _severity;

private _cfgSounds = configFile >> "CfgSounds";
private _targetClass = format ["ACE_moan_%1_%2_", _speaker, _variation];
private _index = 1;
private _sounds = [];
while {isClass (_cfgSounds >> (_targetClass + str _index))} do {
    _sounds pushBack (_cfgSounds >> (_targetClass + str _index));
    _index = _index + 1;
};
private _sound = configName selectRandom _sounds;
if (isNil "_sound") exitWith { WARNING_1("no sounds for target [%1]",_targetClass); };

["ace_medical_feedback_forceSay3D", [_unit, _sound, _distance], _targets] call CBA_fnc_targetEvent;
