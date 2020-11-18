/*
  fnc_s_loadout_zu_objektliste
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.02
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: unnecessary

  Please give the author the necessary credits if you use this script or change it. The script was created in context to other functions
  of the author and guarantees no functionalities with other scripts and functions that were not developed by athor expilizit for it.
*/
params ["_unit"];
private _objektliste = [];
private _segment = [];
private _eintrag = [];
private _eintrag_sub = [];
private _eintrag_sub_sub = [];
{
  _segment = _x;
  if (((typename _segment) == "STRING") && {_x != ""}) then {_objektliste pushback _segment};
  if ((typename _segment) == "ARRAY") then {
    {
      _eintrag = _x;
      if (((typename _eintrag) == "STRING") && {_x != ""}) then {_objektliste pushback _eintrag};
      if ((typename _eintrag) == "ARRAY") then {
        {
          _eintrag_sub = _x;
          if (((typename _eintrag_sub) == "STRING") && {_x != ""}) then {_objektliste pushback _eintrag_sub};
          if ((typename _eintrag_sub) == "ARRAY") then {
            {
              _eintrag_sub_sub = _x;
              if (((typename _eintrag_sub_sub) == "STRING") && {_x != ""}) then {_objektliste pushback _eintrag_sub_sub};
              if ((typename _eintrag_sub_sub) == "ARRAY") then {
                {
                  if (((typename _x) == "STRING") && {_x != ""}) then {_objektliste pushback _x};
                } foreach _eintrag_sub_sub;
              };
            } foreach _eintrag_sub;
          };
        } foreach _eintrag;
      };
    } foreach _segment;
  };
} foreach (getunitloadout _unit);
_objektliste
