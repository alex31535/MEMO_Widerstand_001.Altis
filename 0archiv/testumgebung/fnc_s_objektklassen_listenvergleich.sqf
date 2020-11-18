/*
  fnc_s_objektklassen_listenvergleich
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.13
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: unnecessary

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
params ["_objektliste","_referenzliste"];
private _obj_klasse = "";
private _objekt_in_referenzliste = false;
private _liste_neue_obj = [];
{
  _obj_klasse = tolower _x;
  _objekt_in_referenzliste = false;
  {
    if ((tolower _x) == _obj_klasse) exitwith {_objekt_in_referenzliste = true};
  } foreach _referenzliste;
  if ((!_objekt_in_referenzliste) && {(_liste_neue_obj find _obj_klasse) == -1}) then {_liste_neue_obj pushback _obj_klasse};
} foreach _objektliste;
_liste_neue_obj
