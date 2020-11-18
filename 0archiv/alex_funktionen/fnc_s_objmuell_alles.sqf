/*
  fnc_s_objmuell_alles
  Author: Alex31535 (alex31535@miegelke.de)
  Version:
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Necessary functions:
	Example: unnecessary

  Please give the author the necessary credits if you use or change this script. The script was created in the context
  of other functions of the author and does not guarantee functionalities with other scripts and functions that were not
  developed for this by the author.
*/
{deletevehicle (_x select 0)} foreach s_objektmuelleimer;
s_objektmuelleimer = s_objektmuelleimer select {!isnull (_x select 0)};
s_objmuell_naechste_leerung = time + s_objmuell_intervall;
