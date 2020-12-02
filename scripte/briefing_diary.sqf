/*
  briefing_diary.sqf
  Author: Alex31535 (alex31535@miegelke.de)
  Version: 1.01
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
private _name_spieler = name player;
private _text = "";
private _text_titel = "";
player createDiarySubject ["MEMO Widerstand","MEMO Widerstand"];
//------------------------------------------------------------------------------------------------------------------------------------eintrag: Gefaengnis
_text_titel = "Gefaengnis";
_text =  							  "In das Gefaengnis kommt jeder der einen Kameraden toetet.";
_text = _text + 				"<br />Eine Inhaftierung erfolgt unmittelbar nach einem Abschlussbericht";
_text = _text + 				"<br />an den Basis-Kommandeur.";
_text = _text + 				"<br />Die Inhalftierungszeit wird in Anhaengigkeit aller vorheringen";
_text = _text + 				"<br />Toetungen ermittelt.";
_text = _text + 				"<br />Beispiel:";
_text = _text + 				"<br />1. Toetung = 5 Sekunden Haft";
_text = _text + 				"<br />2. Toetung = 10 Sekunden Haft";
_text = _text + 				"<br />3. Toetung = 15 Sekunden Haft";
_text = _text + 				"<br />10. Toetung = 50 Sekunden Haft";
_text = _text + 				"<br />etc...";
_text = _text + 				"<br />Das Gefaengnis VERGISST NIE! Alle Vergehen bleiben erhalten!";
player createDiaryRecord ["MEMO Widerstand", [_text_titel, _text]];
//------------------------------------------------------------------------------------------------------------------------------------eintrag: Basis-Kommandeur
_text_titel = "Basis-Kommandeur";
_text =  							  "Kehrt man von einer Mission zurueck, so wird dem Kommandeur ein Bericht";
_text = _text + 				"<br />erstattet. Durch diesen Abschlussbericht weiss der Kommandeur";
_text = _text + 				"<br />welche Erfolge (Punkte) die letzte Mission erzielt halt.";
_text = _text + 				"<br />Die erzielten Punkte verteilt der Gruppenleiter (derjenige, der";
_text = _text + 				"<br />die Mission gestartet hat) nach eigenem Ermessen unter den";
_text = _text + 				"<br />Kaempfern.";
player createDiaryRecord ["MEMO Widerstand", [_text_titel, _text]];
//------------------------------------------------------------------------------------------------------------------------------------eintrag: Garage
_text_titel = "Garage";
_text =  							  "In der Garage befinden sich alle erbeuteten Fahrzeuge.";
_text = _text + 				"<br />Es ist zwingend notwendig mit den Fahrzeugen sorgsam umzugehen,";
_text = _text + 				"<br />da diese limitiert sind. Es ist daher von groesster Wichtigkeit";
_text = _text + 				"<br />dass neue Fahrzeuge gefunden werden und diese in der Garage";
_text = _text + 				"<br />GEPARKT werden";
_text = _text + 				"<br />Alle in der Garage geparkten Fahrzeuge werde automatisch repariert,";
_text = _text + 				"<br />betankt und aufmunitioniert.";
player createDiaryRecord ["MEMO Widerstand", [_text_titel, _text]];
//------------------------------------------------------------------------------------------------------------------------------------eintrag: Waffenkammer
_text_titel = "Waffenkammer";
_text =  							  "Die Waffenkammer enthaelt alle Waffen und Gegenstaende die";
_text = _text + 				"<br />waehrend Gruppen- und Einzelmissionen erbeutet wurden, in";
_text = _text + 				"<br />unlimitiertet Anzahl.";
_text = _text + 				"<br />Es ist voellig ausreichend die Waffenkammer zu aktivieren";
_text = _text + 				"<br />um neue Gegenstaende hinzuzufuegen, sofern die sich in dem";
_text = _text + 				"<br />persoenlichen Inventar befinden.";
player createDiaryRecord ["MEMO Widerstand", [_text_titel, _text]];
//------------------------------------------------------------------------------------------------------------------------------------eintrag: Einsatzplanung
_text_titel = "Einsatzplanung";
_text =  							  "Ueber die EINSATZPLANUNG werden alle Missionstypen gewaehlt:";
_text = _text + 				"<br />Gruppenmissionen:";
_text = _text + 				"<br />Diese Missionen erlauben Angriff, Stabilisierung und";
_text = _text + 				"<br />Verteidigung von Regionen. Eine Gruppenmission erfordert eine";
_text = _text + 				"<br />Mindestanzahl von Kaempfern.";
_text = _text + 				"<br />Gruppenmissionen finden aber auch WECHSELSEITIG zwischen Gegnern";
_text = _text + 				"<br />und dem Widerstand statt. Der Gegner ist am Zug, wenn eine";
_text = _text + 				"<br />Widerstandsmission (unabhaengig vom Ausgang) abgeschlossen ist.";
_text = _text + 				"<br />Waehlt der Widerstand eine Gruppenmission, so ist das Ziel";
_text = _text + 				"<br />abhaengig von dem Level des Kaempfers, der den Missionsaufruf startet.";
_text = _text + 				"<br />Ist der Gegner am Zug, so wird er die schwaechste Region mit der";
_text = _text + 				"<br />staerksten Einheit angreifen, die sich in der Naehe befindet.";
_text = _text + 				"<br />Gruppenmissionen sind der einzige Weg das Land zu befreien!";
_text = _text + 				"<br />Nach Abschluss einer Gruppenmission wird dem Basis-Kommandeur";
_text = _text + 				"<br />Bericht erstattet und die erzielten Punkte werden durch den";
_text = _text + 				"<br />Missionsleiter an die Teilnehmer verteilt.";
_text = _text + 				"<br />";
_text = _text + 				"<br />Einzelmissionen:";
_text = _text + 				"<br />Einzelmissionen koennen folgende Zwecke erfuellen:";
_text = _text + 				"<br />- Erhoehung des persoenlichen Levels";
_text = _text + 				"<br />- Erbeuten von Ausruestungsgegenstaenden";
_text = _text + 				"<br />- Stehlen/Erbeuten von Fahrzeugen";
_text = _text + 				"<br />Die Einzelmissionen koennen von jedem Kaempfer aufgerufen werden,";
_text = _text + 				"<br />sind aber auch in ihren Zielen und der Schwierigkeit abhaengig von";
_text = _text + 				"<br />demjenigen, der die Mission startet.";
_text = _text + 				"<br />Die Einzelmissionen koennen jederzeit von anderen Kaempfern";
_text = _text + 				"<br />Unterstuetzt werden. Es kann aber immer nur EINE Einzelmission";
_text = _text + 				"<br />aufgerufen werden. Mehere Missionen verschiedener Kaempfer sind";
_text = _text + 				"<br />nicht zeitgleich moeglich.";
_text = _text + 				"<br />Nach Abschluss einer Einzelmission wird dem Basis-Kommandeur";
_text = _text + 				"<br />Bericht erstattet, der die erzielten Punkte an den";
_text = _text + 				"<br />Missionsleiter vergibt.";
player createDiaryRecord ["MEMO Widerstand", [_text_titel, _text]];
//------------------------------------------------------------------------------------------------------------------------------------eintrag: Basis
_text_titel = "Die Basis";
_text =  							  "Die Basis besteht aus folgenden Elementen:";
_text = _text + 				"<br />- Einsatzplanung";
_text = _text + 				"<br />Hier koennen Gruppen- oder Einzeleinsaetze abgerufen werden.";
_text = _text + 				"<br />Die Schwierigkeit, bzw der Level der Einsaetze richtet sich immer";
_text = _text + 				"<br />nach der Erfahrung (Level) desjenigen, der den Einsatz aufruft.";
_text = _text + 				"<br />bekaempfen. Plane Deine Einsaetze mit den vorhandenen Resourcen und";
_text = _text + 				"<br />";
_text = _text + 				"<br />- Waffenkammer";
_text = _text + 				"<br />In der Waffenkammer befinden sich alle Gegenstaende die waehrend der";
_text = _text + 				"<br />Einsaetze erbeutet wurden und koennen unlimitiert verwendet werden.";
_text = _text + 				"<br />";
_text = _text + 				"<br />- Garage";
_text = _text + 				"<br />In der Garage sind alle erbeuteten Fahrzeuge. Die Garage repariert";
_text = _text + 				"<br />ein Fahrzeug automatisch und munitioniert dieses auf, wenn das ";
_text = _text + 				"<br />eingeparkt wird. Die Fahrzeugarten stehen NICHT UNENDLICH zur";
_text = _text + 				"<br />Verfuegung.";
_text = _text + 				"<br />";
_text = _text + 				"<br />- Basis-Kommandeur";
_text = _text + 				"<br />Nach Abschluss jeder Mission (Einzel-/Gruppenmissionen) muss dem";
_text = _text + 				"<br />Basis-Kommandeur Berichter erstattet werden um persoenliche";
_text = _text + 				"<br />Erfolge aus den Missionen verbuchen zu koennen.";
_text = _text + 				"<br />";
_text = _text + 				"<br />- Gefaengnis";
_text = _text + 				"<br />In das Gefaengnis kommt jeder der sich ungebuerlich Verhaelt oder";
_text = _text + 				"<br />einen Kameraden toetet. Je haeufiger jemand Rueckfaellig wird,";
_text = _text + 				"<br />desto langer werden seine Haftzeiten";
player createDiaryRecord ["MEMO Widerstand", [_text_titel, _text]];
//------------------------------------------------------------------------------------------------------------------------------------eintrag: Hallo
_text_titel = format["Brief an %1",_name_spieler];
_text =  							format["Hello %1, ",_name_spieler];
_text = _text + 				"<br />";
_text = _text + 				"<br />Willkommen im Widerstand!";
_text = _text + 				"<br />Triff dich mit anderen Kaempfern in unserer Basis.";
_text = _text + 				"<br />In der Basis findest du alles was du brauchst um unsere Feinde zu";
_text = _text + 				"<br />bekaempfen. Plane Deine Einsaetze mit den vorhandenen Resourcen und";
_text = _text + 				"<br />erweitere die Auswahl an Fahrzeugen und Gegenstaenden.";
_text = _text + 				"<br />";
_text = _text + 				"<br />Aller Anfang ist leicht, aber mit steigender Erfahrung wird der Gegner";
_text = _text + 				"<br />dir immer haerter entgegentreten. Auch Banditen sollten nicht";
_text = _text + 				"<br />unterschaetzt werden, da diese jederzeit versuchen destabilile Gebiete";
_text = _text + 				"<br />fuer sich zu beanspruchen.";
_text = _text + 				"<br />";
_text = _text + 				"<br />";
_text = _text + 				"<br />Viel Erfolg,";
_text = _text + 				"<br />Der MEMO Widerstand";
player createDiaryRecord ["MEMO Widerstand", [_text_titel, _text]];
