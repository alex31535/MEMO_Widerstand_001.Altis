//------------------------------------------------------------
// listbox idd-start: 5xxx
class class_lb_missionsparameter {
	idd = 5010; // es ist wichtig hier eine absolut individuelle idd zu vergeben!
	movingenable = false;
	class controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Alex31535, v1.063, #Doxice)
		////////////////////////////////////////////////////////
		class RscFrame_1800: RscFrame
		{
			idc = 5020;
			x = 0.323716 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.352567 * safezoneW;
			h = 0.470196 * safezoneH;
		};
		class lb_namen: RscListbox
		{
			idc = 5200;
			x = 0.345752 * safezoneW + safezoneX;
			y = 0.340133 * safezoneH + safezoneY;
			w = 0.171877 * safezoneW;
			h = 0.282118 * safezoneH;
		};
		class lb_auswahl: RscListbox
		{
			idc = 5400;
			x = 0.535257 * safezoneW + safezoneX;
			y = 0.340133 * safezoneH + safezoneY;
			w = 0.114584 * safezoneW;
			h = 0.282118 * safezoneH;
		};
		class kopftext: RscText
		{
			idc = 5100;
			text = "kopftext"; //--- ToDo: Localize;
			x = 0.336938 * safezoneW + safezoneX;
			y = 0.274306 * safezoneH + safezoneY;
			w = 0.312904 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class infotext: RscStructuredText
		{
			idc = 5500;
			text = "Information zum gewaehlten Parameter..."; //--- ToDo: Localize;
			x = 0.345752 * safezoneW + safezoneX;
			y = 0.631655 * safezoneH + safezoneY;
			w = 0.171877 * safezoneW;
			h = 0.0846353 * safezoneH;
		};
		class text_lb_namen: RscText
		{
			idc = 5040;
			text = "Parameter"; //--- ToDo: Localize;
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.311922 * safezoneH + safezoneY;
			w = 0.185098 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class text_lb_auswahl: RscText
		{
			idc = 5050;
			text = "Einstellung"; //--- ToDo: Localize;
			x = 0.53085 * safezoneW + safezoneX;
			y = 0.311922 * safezoneH + safezoneY;
			w = 0.127806 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class button_fertig: RscButton
		{
			idc = 5030;
			text = "SPEICHERN & BEENDEN"; //--- ToDo: Localize;
			x = 0.535257 * safezoneW + safezoneX;
			y = 0.631655 * safezoneH + safezoneY;
			w = 0.114584 * safezoneW;
			h = 0.0564236 * safezoneH;
		};
		class button_zufall: RscButton
		{
			idc = 5060;
			text = "EGAL (Alles auf Zufall)"; //--- ToDo: Localize;
			x = 0.535257 * safezoneW + safezoneX;
			y = 0.697482 * safezoneH + safezoneY;
			w = 0.114584 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};
