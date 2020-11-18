// listbox idd-start: 2xxx
class class_lb_auswahl_1_2010 {
	idd = 2010; // es ist wichtig hier eine absolut individuelle idd zu vergeben!
	movingenable = false;
	//onload = "[] spawn {execvm 'c_lb_auswahl_1_2010_load.sqf';};";
	class controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Alex31535, v1.063, #Lisini)
		////////////////////////////////////////////////////////
		class lb_test_frame: RscFrame
		{
			idc = 2011;
			text = ""; //--- ToDo: Localize;
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.317311 * safezoneW;
			h = 0.300926 * safezoneH;
		};
		class lb_test_button_ok: RscButton
		{
			idc = 2012;
			text = "OK"; //--- ToDo: Localize;
			x = 0.367787 * safezoneW + safezoneX;
			y = 0.528212 * safezoneH + safezoneY;
			w = 0.092549 * safezoneW;
			h = 0.0470196 * safezoneH;
			//action = "[] spawn {[2010,2014] execvm 'c_lb_auswahl_1_2010_ok.sqf';};";
		};
		class lb_test_button_cancel: RscButton
		{
			idc = 2013;
			text = "CANCEL"; //--- ToDo: Localize;
			x = 0.548478 * safezoneW + safezoneX;
			y = 0.528212 * safezoneH + safezoneY;
			w = 0.092549 * safezoneW;
			h = 0.0470196 * safezoneH;
			action = "closedialog 0;";
		};
		class lb_test_lb: RscListbox
		{
			idc = 2014;
			text = "Listbox"; //--- ToDo: Localize;
			x = 0.367787 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.277647 * safezoneW;
			h = 0.150463 * safezoneH;
		};
		class lb_test_text: RscText
		{
			idc = 2015;
			text = "KOPFTEXT"; //--- ToDo: Localize;
			x = 0.367787 * safezoneW + safezoneX;
			y = 0.311922 * safezoneH + safezoneY;
			w = 0.096956 * safezoneW;
			h = 0.0282118 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
