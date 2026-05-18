/*
 * Author: [Tuntematon]
 * Estimates epinephrine effectiveness for unconscious units
 *
 * Arguments:
 * 0: Unit <OBJECT> (optional, defaults to ace_player)
 *
 * Return Value:
 * [Wake-up chance per check, Epinephrine check-rate boost percent, Chance to wake in next minute, Checks per minute, Base checks per minute] <ARRAY>
 *
 * Example:
 * [ace_player] call tunuti_unconinfo_fnc_epiEstimation
 */

#include "script_component.hpp"

params [ ["_unit", ace_player, [objNull]] ];
if (isNull _unit) then { _unit = ace_player; };

// Epinephrine effectiveness (0..1)
private _epiEff = ([_unit, "Epinephrine", false] call ace_medical_status_fnc_getMedicationCount) select 1;
private _hasEpi = _epiEff > 0;

// Settings / full names
private _perCheckChance = ace_medical_spontaneousWakeUpChance max 0 min 1;
private _epiBoost = ace_medical_spontaneousWakeUpEpinephrineBoost;
private _baseInterval = ace_medical_const_wakeUpCheckInterval; // ACE default: 15 if not set

// Effective check interval after applying epi boost (same logic as ACE)
private _effectiveInterval = _baseInterval * linearConversion [0, 1, _epiEff, 1, 1 / _epiBoost, true];

// Derived probabilities.
private _checksPerMinNoEpi = if (_baseInterval > 0) then { 60 / _baseInterval } else { 0 };
private _checksPerMinWithEpi = if (_effectiveInterval > 0) then { 60 / _effectiveInterval } else { 0 };

private _chancePerMinuteNoEpi = if (_perCheckChance > 0 && _checksPerMinNoEpi > 0) then {
    1 - ((1 - _perCheckChance) ^ _checksPerMinNoEpi)
} else {
    0
};

private _chancePerMinuteWithEpi = if (_perCheckChance > 0 && _checksPerMinWithEpi > 0) then {
    1 - ((1 - _perCheckChance) ^ _checksPerMinWithEpi)
} else {
    0
};

private _epiBoostCheckRate = if (_hasEpi) then {
    if (_checksPerMinNoEpi > 0) then {
        ((_checksPerMinWithEpi - _checksPerMinNoEpi) / _checksPerMinNoEpi) * 100
    } else {
        0
    }
} else {
    0
};

[
    _perCheckChance,
    _epiBoostCheckRate,
    _chancePerMinuteWithEpi,
    _checksPerMinWithEpi,
    _checksPerMinNoEpi
]
