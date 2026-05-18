/*
 * Author: [Tuntematon]
 * Clears unconscious info display when enabled
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_unconinfo_fnc_hideMessage
 */

#include "script_component.hpp"

if (GVAR(enableUnconInfo) && player getVariable ["ACE_isUnconscious", false]) then {
	QGVAR(cutTextLayer) cutText ["", "PLAIN NOFADE", -1, false, true];
};
