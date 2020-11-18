// listbox idd-start: 2xxx
class class_lb_mission_score {
	idd = 6000; // es ist wichtig hier eine absolut individuelle idd zu vergeben!
	movingenable = false;
	//onload = "[] spawn {execvm 'c_lb_auswahl_1_2010_load.sqf';};";
	class controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Alex31535, v1.063, #Jywyho)
		////////////////////////////////////////////////////////

		class frame: RscFrame
		{
			idc = 6001;
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.312904 * safezoneW;
			h = 0.394965 * safezoneH;
		};
		class festtext1: RscText
		{
			idc = 6002;
			text = "Team Pt Total:"; //--- ToDo: Localize;
			x = 0.350159 * safezoneW + safezoneX;
			y = 0.321325 * safezoneH + safezoneY;
			w = 0.048478 * safezoneW;
			h = 0.0376157 * safezoneH;
		};
		class text_leader: RscText
		{
			idc = 6003;
			text = "Total Pt"; //--- ToDo: Localize;
			x = 0.403044 * safezoneW + safezoneX;
			y = 0.321325 * safezoneH + safezoneY;
			w = 0.237983 * safezoneW;
			h = 0.0376157 * safezoneH;
		};
		class festtext2: RscText
		{
			idc = 6004;
			text = "Score Detail:"; //--- ToDo: Localize;
			x = 0.350159 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.048478 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class text_score_leader_basis: RscText
		{
			idc = 6005;
			text = "123456789012345678901234567890"; //--- ToDo: Localize;
			x = 0.403044 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class festtext3: RscText
		{
			idc = 6006;
			text = ""; //--- ToDo: Localize;
			x = 0.544071 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.00881418 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class text_score_rest: RscText
		{
			idc = 6007;
			text = "23"; //--- ToDo: Localize;
			x = 0.557292 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.0308496 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class lb_units: RscListbox
		{
			idc = 6008;
			x = 0.350159 * safezoneW + safezoneX;
			y = 0.396557 * safezoneH + safezoneY;
			w = 0.286461 * safezoneW;
			h = 0.206886 * safezoneH;
		};
		class btn_score_plus: RscButton
		{
			idc = 6009;
			text = "Score +"; //--- ToDo: Localize;
			x = 0.358973 * safezoneW + safezoneX;
			y = 0.622251 * safezoneH + safezoneY;
			w = 0.048478 * safezoneW;
			h = 0.0282118 * safezoneH;
		};
		class btn_score_minus: RscButton
		{
			idc = 6010;
			text = "Score -"; //--- ToDo: Localize;
			x = 0.420672 * safezoneW + safezoneX;
			y = 0.622251 * safezoneH + safezoneY;
			w = 0.048478 * safezoneW;
			h = 0.0282118 * safezoneH;
		};
		class btn_done: RscButton
		{
			idc = 6011;
			text = "Done"; //--- ToDo: Localize;
			x = 0.592549 * safezoneW + safezoneX;
			y = 0.622251 * safezoneH + safezoneY;
			w = 0.0308496 * safezoneW;
			h = 0.0282118 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
