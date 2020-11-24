/*
  fnc_s_locmarker_selectarea_an_aus
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.12
	Description:
  Called by:
	Parameters:
	Returns:
  Necessary Globals:
	Example: [OBJ, KLASSE, DISPLAYNAME] = [fzg_pos_obj_area, "LandVehicle"] call fnc_s_LandVehicle_im_garagenbereich;

  Please give the Author the necessary Credits if you use this Script or change it. The script was created in Context to other Functions
  of the Author and guarantees no Functionalities with other Scripts and Functions that were not developed by Athor expilizit for it.
*/
private _alpha = 0;
{
  _alpha = if ((markeralpha (format["m_loc_area_%1",_foreachindex])) == 1) then [{0},{1}];
  (format["m_loc_area_%1",_foreachindex]) setmarkeralpha _alpha;
} foreach s_loc_params;
