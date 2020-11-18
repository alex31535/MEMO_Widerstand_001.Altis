// listbox idd-start: 2xxx
class class_lb_verwaltung {
	idd = 4000; // es ist wichtig hier eine absolut individuelle idd zu vergeben!
	movingenable = false;
	//onload = "[] spawn {execvm 'c_lb_auswahl_1_2010_load.sqf';};";
	class controls {
		// GUI EDITOR OUTPUT START (by Alex31535, v1.063, #Wasydi)
		////////////////////////////////////////////////////////
		class frame: RscFrame
		{
			idc = 4001;
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.317311 * safezoneW;
			h = 0.394965 * safezoneH;
		};
		class hintergrund: IGUIBack
		{
			idc = 4002;
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.317311 * safezoneW;
			h = 0.394965 * safezoneH;
			colorBackground[] = {0,0,0,0.75};
		};
		class listbox: RscListbox
		{
			idc = 4003;
			x = 0.358973 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.123399 * safezoneW;
			h = 0.282118 * safezoneH;
		};
		class text: RscStructuredText
		{
			idc = 4004;
			x = 0.491186 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.149841 * safezoneW;
			h = 0.282118 * safezoneH;
		};
		class txt_esc_to_exit: RscText
		{
			idc = 4005;
			text = "Press ESC to exit Administration"; //--- ToDo: Localize;
			x = 0.358973 * safezoneW + safezoneX;
			y = 0.659867 * safezoneH + safezoneY;
			w = 0.13662 * safezoneW;
			h = 0.0188079 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class txt_select_soldier: RscText
		{
			idc = 4006;
			text = "Select a Soldier to view his Profile"; //--- ToDo: Localize;
			x = 0.362338 * safezoneW + safezoneX;
			y = 0.321325 * safezoneH + safezoneY;
			w = 0.277647 * safezoneW;
			h = 0.0188079 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
