/*
  fnc_s_gruppenmission_starten_ki
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
// # einen ja/nein-box wird eingeblendet um auf level-wah hinzuweisen; eine lokale namespace-var wird benutzt um limitierungen im namespace-dialog zu umgehen
a_temp_ja_nein = false;
private _text = "<t color='#ff9900' size='2'>Als naechstes ist der Gegner am Zug! Moechtest du fortfahren?";
[_text] call fnc_a_ja_nein;
if (!a_temp_ja_nein) exitwith {a_temp_ja_nein = nil};
a_temp_ja_nein = nil;


[] remoteexec ["fnc_s_gruppenmission_starten_ki",2];
