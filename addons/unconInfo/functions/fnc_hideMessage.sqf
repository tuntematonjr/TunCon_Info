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
 * [] call tuncon_unconinfo_fnc_hideMessage
 */
#include "script_component.hpp"

if (GVAR(enableUnconInfo) && player getVariable ["ACE_isUnconscious", false]) then {
	cutText ["", "PLAIN NOFADE", -1, false, true];
};