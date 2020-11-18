class class_text_ja_nein {
	idd = 3010; // es ist wichtig hier eine absolut individuelle idd zu vergeben!
	movingenable = false;
	//onload = "[] spawn {execvm 'c_lb_auswahl_1_2010_load.sqf';};";
	class controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Alex31535, v1.063, #Lufyba)
		////////////////////////////////////////////////////////
		class frame: RscFrame
		{
			idc = 3011;
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.377749 * safezoneH + safezoneY;
			w = 0.321718 * safezoneW;
			h = 0.26331 * safezoneH;
		};
		class text: RscStructuredText
		{
			idc = 3012;
			x = 0.358973 * safezoneW + safezoneX;
			y = 0.396557 * safezoneH + safezoneY;
			w = 0.286461 * safezoneW;
			h = 0.169271 * safezoneH;
		};
		class btn_yes: RscButton
		{
			idc = 3013;
			text = "YES"; //--- ToDo: Localize;
			x = 0.358973 * safezoneW + safezoneX;
			y = 0.584635 * safezoneH + safezoneY;
			w = 0.0749206 * safezoneW;
			h = 0.0376157 * safezoneH;
		};
		class btn_no: RscButton
		{
			idc = 3014;
			text = "NO"; //--- ToDo: Localize;
			x = 0.570513 * safezoneW + safezoneX;
			y = 0.584635 * safezoneH + safezoneY;
			w = 0.0749206 * safezoneW;
			h = 0.0376157 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
