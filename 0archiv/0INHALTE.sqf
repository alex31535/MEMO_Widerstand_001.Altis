@CBA_A3;
@CUP Terrains - Core;
@CUP Terrains - Maps;
@CUP Units;
@CUP Vehicles;
@CUP Weapons;
@TFAR;
@INIDBI2;
GM; 


###################################################################################################################################################DRINGEND
neue version: memo_048
201108 modul "missionen": "Rettung Z": parameter zur bestimmung der zombie-fraktion; kann bewirken, dass zombies mit normalen feinden "befreundet" sind
201106 modul "missionen": "Rettung Z": F: keine zufallssortierung der zivilisten-positionen (fehler lag im arrayshuffe)
201107 modul "missionen": "Rettung Z": missionsende bei 50% zivil-verlust
# modul "missionen": "Rettung Z": einstellbares verhältnis der gegner für zombie(versch. typen) und bewaffnete einheimische
201106 modul "missionen": "Rettung Z": zivilisten dürfen bei beschädigung des heli nicht aussteigen -> X allowCrewInImmobile true; X setUnloadInCombat [false, false];
201105 modul "missionen": "Rettung Z": nur transport-heli fest einbinden
# modul "garage hq / wasser": rad kette flug heli einzeln abschaltbar machen
201105 modul "missionen": "Rettung Z": parameter-wahl
201105 modul "missionen": "Rettung Z": zombies auf "fast" + anteil demons reduzieren
201104 Framework: synchro mit systemzeit
201103 modul "SpCFG": "psycho": pilotenausstattung wieder hinzugefügt
# Framework: ladebildschirm
# modul "missionen": "hundekampf": ....
# modul "missionen": "verteidigung zombie": parameter-einträge verständlicher beschreiben (spawn-entfernung zu "kommen schneller" o.ä.)
201103 modul "missionen": "verteidigung zombie": waehlbares verhältnis zwischen east und zombie
# modul "missionen": "verteidigung": F: bei "0%" scheint sich GENERIEREN im endlos zu verlieren
VERWORFEN modul "missionen": "verteidigung": moerser permanent setzen und nur bei bedarf triggern
# modul "missionen": "verteidigung": vec-limit (vehicles)
# modul "missionen": "verteidigung": unit-limit (units)
# modul "missionen": "verteidigung": max-objekte effektiver überwachen
# modul "missionen": "mibu liberty": map-abhaengig die positionierungen auf der liberty setzen
# modul "missionen": "mibu liberty": in abhaengigkeit von vorhandenem wasser
# modul "garage hafen": in abhaengigkeit von vorhandenem wasser
# Framework: systemabfrage ob wasser vorhanden ist
# modul "missionen": "wandern mit psycho": ....
# modul "missionen": eigene einträge zur (de-)aktivierung von garagen-sparten (heli, rad, kette,...)
# modul "garage hq": unterschiedliche auspark-zonen für heli, flug, kette und rad



+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  MISSION-/MP-FRAMEWORK
201026 "objektmuelleimer": code optimieren und dead(all...) einbinden
201016 Framework: funktionen zusammenfassen part #3
201016 tfar: für alle fahrzeuge erzwingen : _vehicle setVariable ["tf_hasRadio", true, true]
201016 Framework: funktionen zusammenfassen part #2
201016 tfar: lr-startfrequenzen einstellen: [(call TFAR_fnc_activeLrRadio), 1, "75"] call TFAR_fnc_SetChannelFrequency; (nur rucksäcke)
201310 tfar: sw-startfrequenzen einstellen: [(call TFAR_fnc_activeSwRadio), 1, "111"] call TFAR_fnc_SetChannelFrequency;
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ EDITOR:
201002 EDITOR: hq-aufbau am ende der landebahn
200923 EDITOR: spielfiguren nur mit uniform, funkgerät und karte
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ modul "HQ" / modul "missionen":
# modul "missionen": "mibu liberty": die liberty besteht aus einzelelementen! diese muessen separat angesprochen werden (allowdammage, doors....https://community.bistudio.com/wiki/BIS_fnc_Destroyer01Init)
# modul "missionen": "mibu liberty": heli heimfliegen und landen
# modul "missionen": "hotel tanoa": geiseln aus hotel befreien (nur tanoa)
# modul "missionen": "hotel altis": geiseln aus ghosthotel befreien (nur altis)
# modul "missionen": "bläckis geburtstagsmission": reaktion auf zielfahrzeug: transport-helis setzen at-truppen zwischen zielfahrzeug und hq ab
# modul "missionen": "bläckis geburtstagsmission": anzahl fluggeräte start/reaktion wählbar in init
# modul "missionen": "bläckis geburtstagsmission": F: zerstörung des zielfahrzeugs wird nicht erkannt
# modul "missionen": KEINE MISSION: teamkill bestrafen mit gefängnis
# modul "missionen": "mibus deathmatch": ähnlich "witteks dm deluxe", aber der spieler suchen sich bei jedem neuen punkt auch neue waffen aus + ki-lvl-up
# modul "missionen": "FR": verhindern, dass die zivilisten "fliehen" oder umherrennen wenn es heiss wird
# modul "missionen": "witteks dm": ctf-stil gegeneinander mit snipern.....pvp-haeuserkampf...waehlbar ob pvp oder pve
# modul "missionen": "witteks dm": highscore-liste
# modul "missionen": beleuchtungselemente für missionsgeber-zone (eo_missionsgeber_lampe_1) ueberwachen
# modul "missionen": datenbank und abfragesystem für global verwendbaren score
# modul "HQ": rang? dienstgrad? waffengattung?
# modul "HQ": jeder spieler kann sich hier seine personalakte anzeigen lassen (kills, vergehen, etc, etc)
# modul "HQ" gefängnis-bereich:
                    eo_hq_gefaengnis, "Land_i_Shed_Ind_F", allowdammage false, locked
                    behörden werden erst aufmerksam wenn a)personalakte aufgerufen wird, b) bei connect c) aufruf spcfg d) aufruf garage, e) aufruf mission
                    pro vergehen +10 sekunden
                    auf bau akte: gefaengnisakte_altis_UID = [
                      name
                      uid
                      vergehen insgesamt
                      nicht bestrafte vergehen : ...also keine restl. haftzeit - diese wird sofort kalkuliert und angetreten bei connect oder personalaufruf
                      zzt in haft (restliche haftzeit) : ist bei connect noch zeit offen, dann geht der spieler sofort ins gefängnis
                      [loadout bei haftantritt]
                      [worldpos bei haftantritt]
                    ]
# modul "HQ": mehrstufige auswahl von missions-parametern bei missionsstart: ort -> uhrzeit -> wetter -> nebel -> ki-lvl
# modul "missionen": "verräter": 5 spieler reise zu loc, jeder besetzt vorgegebenes haus und darf es nicht verlassen, 1 spieler soll einen anderen eliminieren
# modul "missionen": "panzer: lieferung": 3 panzer von a nach b, ki-fahrer, geschw. limitiert, angreifer spawnen in umfeld
# modul "missionen": "gustl": irgendwo abspringen, einnehmen und mit jeep zurück
# modul "missionen": "fahrzeug": ein wunschfahrzeug wählen und dieses aus einem feindsektor stehlen
# modul "missionen": "battle royale"
# modul "missionen": "stadt verteidigen"
# modul "missionen": "fliehen": spieler sind gefangen, fliehen zum HQ, bei respawn: spieler in einem haus in umgebung, abbruchbedingungen?
# modul "missionen": "gold": team-absprung über zielgebiet (bank, hangar, etc), dann wachen erledigen, gold-fahrzeug (langsam) stehlen und bis zielort verteidigen
201028 modul "missionen": "verteidigung": 1x darter-drohne, 1x statisches hmg, 1x statisches gmg
201026 modul "missionen": "verteidigung": F: moerser-call funktioniert bei allen "fired" events -> war auf projektil nicht auf munition gestellt
201026 modul "missionen": loeschen: minen loeschen
201021 modul "missionen": "Todeskult der blinden Priester"(TKDBP/ANGST): ....beta....
201021 modul "missionen": "verteidigung": RC 1.0 (beta-Phase verlassen)
201021 modul "missionen": "verteidigung": vor missionsstart frei konfigurierbar auf ca 1,25Mio moeglichkeiten
201021 modul "missionen": "verteidigung": letzte konfiguration wird dauerhaft auf server gespeichert
201018 modul "missionen": "verteidigung": feind-fluggeräte spawnen
201018 modul "missionen": "verteidigung": feind-fzg spawnen
201018 modul "missionen": "verteidigung": punktezaehler
201013 modul "missionen": "verteidigung": offizier in der stadt vor spawnenden gegner schützen
201013 modul "missionen": "verteidigung": stadt zufällig machen
201008 modul "missionen": "heavy load hardcore": gegner brauchen bessere ausstattungen
201008 modul "missionen": "heavy load hardcore": anz gegener passt sich an anzahl der spieler an
201006 modul "missionen": "heavy load hardcore": wie "heavy load", aber nur mit infanterie und start ausserhalb hq....
201005 modul "missionen": "heavy load": F: die fahrer-ki wird nicht gelöscht (zb bei notaus) -> fahrer war nicht in liste der erstellten objekte
201005 modul "missionen": F: missionsende/notaus: rückholung aller spieler und löschung aller erstellten elemente verbessern!
201004 modul "missionen": "heavy load": heavy_load.......
201004 modul "HQ": missionsgeber-objekt und teilnahme-objekt ohne physik, da ansonsten bei explosion diese umhergeschleudert werden
201003 modul "HQ": ki entlassen
201003 modul "missionen": "bläckis geburtstagsmission": inseln werden nun ausgeschlossen
200930 modul "HQ": ki rekrutieren (nur admin)
200927 modul "missionen": "bläckis geburtstagsmission": zusätzliche helis und flugzeuge bei reaktion auf zielfahrzeug
200927 modul "missionen": "bläckis geburtstagsmission": helis am anfang über ziellocation
200927 modul "missionen": "bläckis geburtstagsmission": reaktion auf zielfahrzeug: fusstruppen und fahrzeuge unterschiedlich bewegen, ggf waypoints
200925 modul "missionen": notaus/aktivierung einer mission: spieler-schaden auf null setzen
200923 modul "missionen": "FR": verhindern, dass die zielperson "abhaut"
200923 modul "missionen": löschen/beenden alles löschen, spieler zurückholen
200923 modul "missionen": aktivierung einer mission transportiert alle spieler in die basis, fahrzeuge ausserhalb hq werden gelöscht, spieler mit grundausstattung
200923 modul "missionen": missionen nur abrufbar wenn alle spieler im hq-bereich(bzw missions-auswahl-bereich)
200923 modul "missionen": ALLE MISSIONSMODULE: schalter einfuegen für arsenal an/aus
200923 modul "missionen": ALLE MISSIONSMODULE: schalter einfuegen für garagen an/aus
200923 modul "missionen": "mibu liberty": galeriepositionen im hangar werden nicht mehr besetzt
200923 modul "missionen": "mibu liberty": waffentürme regelmässig aufmunitionieren
200923 modul "missionen": "mibu liberty": story: geiseln mit sprengstoffwesten, gezündet wenn zeit zuende, ausser gefahr wenn x meter von schiff entfernt
200923 modul "missionen": "mibu liberty": fehlschlag wenn geisel stirbt
200923 modul "missionen": "mibu liberty": nach neustart der mission sind die zeiten falsch gesetzt!
200922 modul "missionen": "witteks dm deluxe ": gruppen sammeln an punkt, dann weiter zum nächsten punkt, und so weiter ...
200922 modul "missionen": "witteks dm": F: scriptfehler ....."_dm_area"...direkt nach teilnahme -> fehler bei uebergabe an client entfernt
200921 modul "missionen": löschen: spieler landen in der luft über position -> neues positionierungsobjekt gesetzt
200921 modul "missionen": "mibu liberty": bei missionsstart alle türen schliessen -> liberty wird jedesmal neu erstellt und anfänglich (init) geloescht
200921 modul "missionen": "mibu liberty": ki auf flugdeck muss "einfacher" positioniert werden -> nur noch 1 deckwache
200921 modul "missionen": "mibu liberty": taucher an leitern
200920 modul "missionen": "mibu liberty": geiseln sollten loadout "deckpersonal" tragen -> tragen weste PRESSE
200920 modul "missionen": s_mission_loeschen.sqf: fehler "s_slive_startpos_west" nicht gefunden -> abfrage auf vorhandensein von "s_slive_startpos_west" ansonsten: eo_admin_lampe_1
200919 modul "missionen": "mibu liberty": mehr loadout-variationen bei geiselnehmern
200919 modul "missionen": "mibu liberty": geiselnehmer sollten medikit haben (zufall?)
200917 modul "missionen": mission: "mibu liberty": anz geiseln auf cargo-plaetze des deck-heli begrenzt, ai-move deaktviert um am boden zu binden, teleport in heli bei berührung
200917 modul "missionen": mission: "mibu liberty": erstellte ki mit admin-ki-lvl verknüpfen
200917 modul "missionen": mission: "mibu liberty": abgeschlossener heli auf deck, der freigeschaltet wird sobald alle geiselnehmer eliminiert sindc
200917 modul "missionen": mission: "mibu liberty": deko des schiffs auf korrektes setzen prüfen!
200917 modul "missionen": mission: "mibu liberty": bewaffnung des schiffs auf korrektes setzen prüfen!
200908 modul: "hq": elememt für missionen diesem modul zuweisen (eo_hq_missionsgeber)
200908 modul "missionen": auswahl von missionen
200908 modul "missionen": "witteks dm": F: bei notaus stribt der spieler wenn er zurückgeholt wird
200908 modul "missionen": eine funktion die eine art "missionsreset" durchführt - abrufbar bei notaus oder missionsende -> [alex_missions\s_mission_loeschen.sqf]
200908 modul: "hq": eo_hq_missionsteilnahme - ein obj das a) die mission anzeigt und b) an der mission teilnehmen lässt, sofern diese nicht vom hq aus gesteuert wird (zb witek/dm)
200908 modul "missionen": es muss eine universelle missions-var geben die aufschluss darüber gibt, ob und welche mission aktiv ist. über diese var kann dann auch eine mission beendet werden.
200913 modul "missionen": mission: "mibu liberty": schiff, tauchen, retten fliehen....
200908 modul "missionen": mission: "deathmatch" in "Witek" umbenennen
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ modul "inkognito":
# modul "inkognito" als startvariation
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ system "objektklassen":
201003 system "objektklassen": modauswahl über das setzen von editor-objekte: bsp: cup-fahrzeug("Air") in editor, benennung eo_mod_1, mod wird gelesen, modul geloescht
201003 system "objektklassen": locations werden nun mit einem marke "auf insel" versehen
200930 system "objektklassen": cup-fahrzeuge in garage (land/luft)
200925 system "objektklassen": locationliste mit "city-ringen"
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ modul "admin":
# modul "admin": garagen: ein-/aus-schalten
# modul "admin": admin-objekt ohne physik, da ansonsten bei explosion diese umhergeschleudert werden
# modul "admin": datenbanken löschen
200930 modul "admin": spieler in hq holen
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ modul "garage HQ / wasser":
# modul "garage hq / wasser": brennende vec/wracks bei aufruf "ausparken" entfernen
# modul "garage hq": fob - ein haus zu einem fob umfunktionieren
201005 modul "garage wasser": verhindern, dass mehere spieler gleichzeitig ausparken - bei abschluss eine abfrage auf blockade des garagenbereichs gesetzt
201005 modul "garage hq": verhindern, dass mehere spieler gleichzeitig ausparken - bei abschluss eine abfrage auf blockade des garagenbereichs gesetzt
200923 modul "garage hq / wasser": schalter einfuegen der es erlaubt bei missions-aktivierung die garagen zu sperren
200923 modul "garage hq / wasser": feste auswahl an vorgegebenen fahrzeugen, keine datenbank mehr
200923 modul "garage hq / wasser": fob nur wenn auch cargospace vorhanden
200922 modul "garage wasser": marker auf karte als "hafen"
200918 modul "garage wasser": bei fob-transfer in ein sdv erscheint meldung "nicht möglich" obwohl tauchausrüstung getragen wird -> abfrage auf tauchgerät reduziert
200913 modul "garage hq / wasser": möglichkeit zwischen garagen zu reisen
200913 modul "garage wasser": eigenständige garage für wasserfahrzeuge
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ modul "SpCFG":
# modul "SpCFG": letzte arsenalausstattung auch in datenbank speichern
# modul "SpCFG": Nach Kill-Respawn erhaelt der Spieler die letzte arsenalausstattung
# modul "SpCFG": ausstattungsobjekt ohne physik (witti sprengt die kiste ansonsten irgendwo hin)
201005 modul "SpCFG": "psycho": einbindung in schnellauswahl und funktionalität gewährleisten
200930 modul "SpCFG": tfar: longrange-rucksäcke in waffenlammer
200930 modul "SpCFG": lasermarker in waffenkammer
200923 modul "SpCFG": schalter einfuegen der es erlaubt bei missions-aktivierung das arsenal/ausstattung zu sperren
200922 modul "SpCFG": letzte arsenalausstattung speichern
200922 modul "SpCFG": ausbauen:arsenal-funktion einsetzen: option 1: volles arsenal, option 2: datenbank/whitelist-arsenal (erweiterbar durch hinzufuegen von gegenstaenden: nur manuell!)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ modul "TSM":
# modul "TSM": prüfen ob der eh handlescore nach respawn eines spielers via remote auf den spieler gesetzt werden muss oder ob es reicht wenn der eh vom server gesetzt wird
# modul "TSM": kill-abfrage auf teamkill, ziv-kill, etc....mit entsprechender textausgabe und global verwendbarem (missions-)score
# modul "TSM": erweiterunghsmöglichkeit: gefängnis - zu viele teamkill oder zivkill setzt den kameraden in ein gefängnis (mit gefängnisakte)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ modul "slive":
F modul "slive": wenn dedicated restart ausgeführt wird, dann erscheinen bei einigen spieler ki-mitglieder nach dem connect
# modul "slive": figur "festsetzen" bis initialisierung abgeschlossen ist
# modul "slive": erst ausstattung setzen wenn alles initialisiert ist
# modul "slive": figur nicht als "überlebender" anzeigen
F modul "slive": die umsetzung der blickrichtung funktioniert nicht richtig
F modul "slive": bei client-disconnect und anschl. re-connect wird die blickrichtung nicht umgesetzt
O modul "slive": globaler login: spieler sollte erst an finale position gesetzt werden, nachdem "los gehts" erscheint
F modul "slive": globaler login: spieler zwischen "datenprüfung" und "los gehts" wird der bildschirm kurz eingeblendet, das sollte nicht sein
# modul "slive": option zur nicht-umsetzung der startposition hinzufügen (für respawn-menu)
# modul "slive": haltung umsetzen
# modul "slive": schadensmodel umsetzen
200923 modul "slive": keine gespeicherte position bei neu-connect umsetzen - der spieler sollte IMMER im hq starten
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ system "killing":
# system "killing": eh(mission): töten von kameraden bestrafen
# system "killing": eh(mission): töten von ki gleicher seite bestrafen
# system "killing": eh(mission): töten von zivilisten bestrafen / negativ-punkte für ziv-kill auf missionspunkte der widerstandgruppe
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ modul: "rebellen":
# modul: "rebellen": um spieler herum spawnende feindeinheiten....entweder missionsgesteuert oder auch ein/ausschaltbar über admin
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//-----ohne priorität------------------------------------------------------------------
# grenzzäune schliessen und unzerstörbar
# event: wenn spieler als "am boden liegt" und kein weiter spieler in umkreis X, dann "verhaften"
# location-besetzung: frame-drop verringern/vermeiden
F strassensperre in einigen fällen bewegen sich die suchenden einheiten nicht (festgestellt, wenn nur 1 strasse gesperrt wurde)
# slive: pos-neu-selection nach ost, west, etc
# garage: db aufteilen nach west, ost, etc

//------------------------------------------------
// spezielles
community-test 200817 F: missionsende, pos-abfrage fuer fzg scheint nicht zu klappen (wenn fzg in garage, dann missionsende durch fehlschlag [fzg zerstoert])
community-test 200817 testmission: offizier-kill sollte sek-einsatz ausloesen
community-test 200817 schnellbewaffnung durch tastendruck?
  https://steamcommunity.com/app/107410/discussions/0/627456486815789730/?l=german
community-test 200817 respawn-auswahl, bzw respawn allgemein sollte ueberarbeitet werden. kein system-auswahlmenue sonder eine karte mit auswahlpunkten am hq
# sek-event wenn grenzzäune offen
# grenzzäune "knack"-bar mit werkzeug
# verhaftung: gefängnisgebäude feststellen und separate räume ohne türfunktion, aber mit werkzeug aufschliessbar
# hq: abruf von wiederstandpunkten
# event: tötung von ost-offizier führt zu sek und strassensperren
# event: tötung von ost-soldat führt zu strassensperren
# missionspunkte bei erfolg auf widerstandsgruppe legen
# polizisten bewaffnen
//------------------------------------------------
MEMO_05
200901 F modul "admin": auf dedicated sind die admin-funbktionen nicht ausführbar (aber der action-befehl ist sichtbar); L: client-funtkionen über init.sqf initialisiert
MEMO_04
200830 modul "garage": mob-fob: reise zu hq verhindern, wenn fzg in bewegung
200830 Misson "FR": verbunden mit admin-ki-konfig
200830 modul "admin": skill-konfig für ki
200829 admin: sterten mit zufaelligen wetter/uhrzeit/nebel
200829 beleuchtungselemente für hq-zone (missionsgeber-beleuchtung gesetzt aber nicht ueberwacht)
200829 autom. hinzufuegen von munitionstypen anhand der vorgegebenen waffen
200828 admin: wetter/uhrzeit/nebel
200828 Misson FR: hinweis auf zp nun mit ungefährer distanz zu ortszentrum (option für winkel befindet sich noch im script-code)
200827 garage/spcfg: das fob verfügt nun über die möglichkeit auf schnellausstattungen und arsenal zuzugreifen
MEMO_03
200826 Misson FR: auswahl an zivilisten erhöht (aus "system-objektklassen")
200826 spcfg: vanilla-ausstattungen anstatt über editor, als init-var setzen
200826 map-abhaengige systemvorgabe für unitklassen anhand installierter server-mods
200825 FR: mögliche ki-gegner ausbauen
200824 # garage: (+feste vanilla-vec) vec-liste: 1. db-prüfung, 2. var-prüfung innerhalb missions-init, 3. editorobjekt-prüfung fuer zusaätzliche vec
200824 F FR: ki spawn UNTERHALB hausposition; L: fnc unit via "setposasl(agltoasl _pos)" auf hausposition gesetzt
200824 FR: nach beendigung einer missionsrunde, wird eine neu aktivierte sofort mit erfolg beendet; L: s_fr_missionsende = 0; fehlte nach beendigung der mission
200824 GARAGE: wenn ein fob abgeschossen wird, verbleibt der respawn an dem wrack; L: abfrage in "fnc_s_garage_mob_fob" auf schaden und anschl. s_garage_mob_fob = objnull
200824 allgemein: wenn punktevergabe deaktiviert wurde, dann ist dese nach respawn eider aktiv L: fehlender eintrag in EH ENTIERESPAWNED
200824 garage: ausparken: auswahlliste wird auf client nicht angezeigt, aber das block-objekt wird erstellt; L: neustrukturierung der client-/server-aufrufe (initialisierung FNC)
200824 garage: transfer zu mobilen FOB...
// v004
v004 200820 alex spieler live (slive) als eigenstaendiges modul das figuren-bezogene spielerdaten speichert
v004 200819 debugmarker als eigenstaendiges modul
v004 200819 objektmuelleimer als eigenstaendiges modul
v004 200818 community-test 200817 ueberpruefen ob fzg aus garage richtig geleert sind (witti hatte angeblich granaten aus dem lkw...) -> clearcargo war nicht gesetzt
v004 200818 garage als eigenstaendiges modul
v004 200818 strassensperren als eigenstaendiges modul
v004 200818 Strassensperren: Bug behoben durch den Strassensperren zu haeufig in einem Gebiet aufgebaut wurden
// v003
v003 200816 Garage: Mobiler Respawn auf alle ausgeparkten Fahrzeuge
v003 200816 Das Widerstands-HQ ist nun als Respawn-Punkt sichtbar
v003 200816 Autom. Client-Synchronisation der aktiven Mission im Diary
v003 200816 Nach Kill-Respawn erhaelt der Spieler immer die Grundausstattung
v003 200816 Nach Kill-Respawn kann nun auch ein mobiles HQ als Spawn-Punkt ausgewaehlt werden
v003 200816 eh disconnect mit speicherung der spielerdaten
v003 200816 Bug entfernt bei dem in seltenen Faellen die Karte nicht aufrufbar war
v003 200816 Missions-Diary hinzugefuegt
v003 200816 Respawn-On-Start inkl. DB-Abfrage
v003 200814 Spielerhaeuser: Das Konzept wurde vollstaendig durch ein fraktionsnhaengiges HQ (Widerstand HQ) ersetzt.
v003 200812 Widerstand HQ: Kopplung mit Garagen-Modul
v003 200812 Widerstand HQ: "Operationszentrale" als Tisch-Objekt
v003 200813 FNC Strassensperre NVA: Bug entfernt durch den suchende Einheiten im Area-Kern gespawnt sind.
v003 200811 Unit-Abhaengige Map-Anzeigen sind nun Serverseitig gesteuert (s_spielanzeigen)
v003 200806 Alle Spielerpunkte sind global unterdrueckt. Kill-Event werden nun mit eigenen Funktionen geprueft
v003 200806 Modul/Funktion "Objektmuelleimer": Autonome Lösung von nicht verwendeten Objekten
v003 200806 Besetzte Locations werden nun auch ueber Objektmuelleimer geloescht
v003 200806 Location-Ueberwachung/-Besetzung ueber System-core
v003 200805 Autom. Speicherung der dynamischen Serverparameter alle x Sekunden
v003 200805 Autom. Speicherung der Spielerdaten alle x Sekunden
v003 200805 Autom. Speicherung der Spielerdaten bei Disconnect
v003 200805 Client-Connect: DB-Inhalte [pos, dir, haltung, gesundheit, ausstattung] lesen oder neu erstellen und sofort umsetzen
------------ INKOGNITO
# nach respawn muss der inkognito-wert auf null gesetzt werden
# onroad-abfrage wenn spieler in fahrzeug
F: getragene waffe führt NUR zur einer erkennungsdistanz von 35 metern
# distanz-bedingungen in gruppen (+kurz, +mittel, +lang) als foreach-schleife mit exit
# geschwindigkeit von fahrzeugen berücksichtigen
v003 200811 INKOGNITO: Bug in der Objekt-Positionspruefung behoben
v003 200811 INKOGNITO: Das Modul liefert Client-Seitige Globals, die zur Gestaltung des HUD genutzt werden können.
v003 200802 INKOGNITO: Das INKOGNITO-System ist nun ein eigenstaendiges Modul, das autark oder als Funktion verwendet werden kann.
