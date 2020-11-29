/*
  fnc_a_ja_nein
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

params ["_text"];
createDialog "class_text_ja_nein";
//ctrlSetText [3012, _text];
((finddisplay 3010) displayctrl 3012) ctrlSetStructuredText (parseText _text);
buttonSetAction [3013, "a_temp_ja_nein = true;closedialog 0;"];
buttonSetAction [3014, "closedialog 0;"];
while {!dialog} do {sleep 0.1};
while {dialog} do {sleep 0.1};
