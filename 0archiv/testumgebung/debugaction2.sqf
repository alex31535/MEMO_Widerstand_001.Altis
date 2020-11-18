if (true) exitwith {};
//(objectparent player) setdammage 0.985;
//player setpos (getmarkerpos "m_test_strassentest");
setDate [1986, 6, 21, 23, 0]; // 4:00pm February 25, 1986
[player] joinsilent (creategroup[east,true]);
player addAction ["Schnueffeln", {}];
_loadout_priester = [[],[],[],["CUP_U_C_Priest_01",[]],[],[],"","",[],["ItemMap","","","ItemCompass","",""]];
player setunitloadout _loadout_priester;
_loadout = [["arifle_MX_GL_F","","acc_flashlight","",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_02_F","","acc_flashlight_pistol","",["6Rnd_45ACP_Cylinder",6],[],""],["U_B_CombatUniform_mcam",[["30Rnd_65x39_caseless_mag",3,30],["1Rnd_HE_Grenade_shell",1,1]]],[],[],"","G_Tactical_Clear",[],["","","","","",""]];
_pos_sprung = getposworld eo_debugscript; deletevehicle eo_debugscript;
player action ["nvGoggles", player];
{
  _x setposworld _pos_sprung;
  if (_x != player) then {
    _x setunitloadout _loadout;
  };
} foreach playableunits;







["WetDistortion", 300, [1, 0, 1, 4.10, 3.70, 2.50, 1.85, 0.0054, 0.0041, 0.05, 0.0070, 1, 1, 1, 1]] spawn
{
	params ["_name", "_priority", "_effect", "_handle"];
	while {_handle = ppEffectCreate [_name, _priority]; _handle < 0} do {_priority = _priority + 1};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 5;
	waitUntil {ppEffectCommitted _handle};
	systemChat "admire effect for a sec";
	uiSleep 3000;
	_handle ppEffectEnable false;
	ppEffectDestroy _handle;
  systemChat "effekt beendet";
};
if (true) exitwith {};


["RadialBlur", 100, [100, 0.5, 0.1, 0.5]] spawn
{
	params ["_name", "_priority", "_effect", "_handle"];
	while {
		_handle = ppEffectCreate [_name, _priority];
		_handle < 0
	} do {
		_priority = _priority + 1;
	};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 5;
	waitUntil {ppEffectCommitted _handle};
	systemChat "admire effect for a sec";
	uiSleep 3;
	_handle ppEffectEnable false;
	ppEffectDestroy _handle;
};



["FilmGrain", 2000, [1, 0.15, 7, 0.2, 1.0, 0]] spawn
{
	params ["_name", "_priority", "_effect", "_handle"];
	while {
		_handle = ppEffectCreate [_name, _priority];
		_handle < 0;
	} do {
		_priority = _priority + 1;
	};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 5;
	waitUntil {ppEffectCommitted _handle};
	systemChat "admire effect for a sec";
	uiSleep 10;
	_handle ppEffectEnable false;
	ppEffectDestroy _handle;
};

if (true) exitwith {};


["ColorInversion", 2500, [0.5, 0.5, 0.5]] spawn
{
	params ["_name", "_priority", "_effect", "_handle"];
	while {
		_handle = ppEffectCreate [_name, _priority];
		_handle < 0
	} do {
		_priority = _priority + 1;
	};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 5;
	waitUntil {ppEffectCommitted _handle};
	systemChat "admire effect for a sec";
	uiSleep 10;
	_handle ppEffectEnable false;
	ppEffectDestroy _handle;
};


if (true) exitwith {};

systemchat "effekt starten...";
["DynamicBlur", 400, [5]] spawn
{
	params ["_name", "_priority", "_effect", "_handle"];
	while {
		_handle = ppEffectCreate [_name, _priority];
		_handle < 0
	} do {
		_priority = _priority + 1;
	};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 5;
	waitUntil {ppEffectCommitted _handle};
	systemChat "admire effect for a sec";
	uiSleep 10;
	_handle ppEffectEnable false;
	ppEffectDestroy _handle;
};
systemchat "effekt beendet...";

if (true) exitwith {};














_handle = ppEffectCreate ["ChromAberration", 200];
_handle ppEffectEnable true;
_handle ppEffectAdjust [10, 10, true];
uiSleep 10;
_handle ppEffectEnable false;
ppEffectDestroy _handle;






["ChromAberration", 200, [0.05, 0.05, true]] spawn {
	params ["_name", "_priority", "_effect", "_handle"];
	while {
		_handle = ppEffectCreate [_name, _priority];
		_handle < 0
	} do {
		_priority = _priority + 1;
	};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 5;
	waitUntil {ppEffectCommitted _handle};
	systemChat "admire effect for a sec";
	uiSleep 3;
	_handle ppEffectEnable false;
	ppEffectDestroy _handle;
};

if (true) exitwith {};


systemchat "effekt starten...";
_hndl = ppEffectCreate ["colorCorrections", 1501];
_hndl ppEffectEnable true;
_hndl ppEffectAdjust [1.0, 1.0, 0.0, [1.0, 0.1, 1.0, 0.75], [0.0, 1.0, 1.0, 1.0], [0.199, 0.587, 0.114, 0.0]];
_hndl ppEffectCommit 0;
sleep 10;
ppEffectDestroy _hndl;
systemchat "effekt beendet...";
