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
 * [] call tun_unconInfo_fnc_hideMessage
 */
#include "script_component.hpp"

if (GVAR(enableUnconInfo) && player getVariable ["ACE_isUnconscious", false]) then {
	hint "test";
	cutText ["", "PLAIN NOFADE", -1, false, true];
};