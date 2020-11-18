//------------------------------------------------------------
// listbox idd-start: 5xxx
class class_angst_beitritt {
	idd = 6010; // es ist wichtig hier eine absolut individuelle idd zu vergeben!
	movingenable = false;
	class controls {
		////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Alex31535, v1.063, #Kykeja)
////////////////////////////////////////////////////////

class frame: RscFrame
{
	idc = 6020;
	x = 0.323716 * safezoneW + safezoneX;
	y = 0.264902 * safezoneH + safezoneY;
	w = 0.352567 * safezoneW;
	h = 0.470196 * safezoneH;
};
class lb_west: RscListbox
{
	idc = 6100;
	x = 0.350159 * safezoneW + safezoneX;
	y = 0.377749 * safezoneH + safezoneY;
	w = 0.114584 * safezoneW;
	h = 0.225694 * safezoneH;
};
class lb_east: RscListbox
{
	idc = 6200;
	x = 0.5 * safezoneW + safezoneX;
	y = 0.377749 * safezoneH + safezoneY;
	w = 0.118992 * safezoneW;
	h = 0.225694 * safezoneH;
};
class kopftext: RscText
{
	idc = 6300;
	text = "KOPFTEXT"; //--- ToDo: Localize;
	x = 0.341345 * safezoneW + safezoneX;
	y = 0.28371 * safezoneH + safezoneY;
	w = 0.317311 * safezoneW;
	h = 0.0376157 * safezoneH;
};
class text_suchtrupp: RscText
{
	idc = 6030;
	text = "Suchtrupp"; //--- ToDo: Localize;
	x = 0.345752 * safezoneW + safezoneX;
	y = 0.340133 * safezoneH + safezoneY;
	w = 0.0352567 * safezoneW;
	h = 0.0470196 * safezoneH;
};
class text_monster: RscText
{
	idc = 6040;
	text = "Priester"; //--- ToDo: Localize;
	x = 0.495593 * safezoneW + safezoneX;
	y = 0.340133 * safezoneH + safezoneY;
	w = 0.0352567 * safezoneW;
	h = 0.0470196 * safezoneH;
};
class button_beitritt_west: RscButton
{
	idc = 6400;
	text = "Beitritt Suchtrupp"; //--- ToDo: Localize;
	x = 0.350159 * safezoneW + safezoneX;
	y = 0.612847 * safezoneH + safezoneY;
	w = 0.114584 * safezoneW;
	h = 0.0282118 * safezoneH;
};
class button_beitritt_east: RscButton
{
	idc = 6500;
	text = "Beitritt Priester"; //--- ToDo: Localize;
	x = 0.5 * safezoneW + safezoneX;
	y = 0.612847 * safezoneH + safezoneY;
	w = 0.118992 * safezoneW;
	h = 0.0282118 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////


	};
};
