-- DB update 2023_03_09_00 -> 2023_03_09_01
DELETE FROM `quest_request_items_locale` WHERE `ID` IN (12, 17, 33, 57, 67, 99, 104, 109, 111, 113, 163, 188, 190, 193, 203, 257, 258, 267, 269, 275, 276, 286, 294, 295, 296) AND `locale` = 'deDE';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12, 'deDE', 'Vielleicht habe ich mich nicht klar genug ausgedrückt, $GKandidat:Kandidatin;. Um Euren Wert als $GDiener:Dienerin; der Volksmiliz und $GDiener:Dienerin; des Lichtes zu beweisen, müsst Ihr 15 Fallensteller der Defias und 15 Schmuggler der Defias erschlagen und zu mir zurückkehren, sobald Ihr dies getan habt.', 0),
(17, 'deDE', 'Habt Ihr die Magentafunguskappen bekommen, die ich für meine alchimistische Arbeit benötige? Keine Kappen - keine Belohnung!', 0),
(33, 'deDE', 'He, $N, ich kriege langsam Hunger. Habt Ihr das zähe Wolfsfleisch bekommen?', 0),
(57, 'deDE', 'Kehrt zu mir zurück sobald Ihr 15 Skelettscheusale und 15 Skelettschrecken getötet habt, $N.', 0),
(67, 'deDE', NULL, 0),
(99, 'deDE', 'Habt Ihr die Lohenscheitfesseln schon sichergestellt, $N?', 0),
(104, 'deDE', 'Habt Ihr der Bedrohung namens Trübauge dem Alten schon den Garaus gemacht? Er ist gesehen worden, wie er an der Küste von Westfall umherstreifte.$B$BKehrt zu mir zurück, sobald das garstige Ungeheuer tot ist.', 0),
(109, 'deDE', NULL, 0),
(111, 'deDE', NULL, 0),
(113, 'deDE', 'Na, Unterfeldmesser $N, hat der alte Stößelbruch diesen Bericht schon fertig?', 0),
(163, 'deDE', NULL, 0),
(188, 'deDE', 'Wie läuft die Jagd auf Sin\'Dall?', 0),
(190, 'deDE', 'Ein echter Pantherjäger wäre jetzt da draußen und würde seiner Beute nachstellen. Zeigt etwas Engagement, $C, und macht, dass Ihr wieder ins Feld kommt.', 0),
(193, 'deDE', 'Bhag\'thera ist oft so gut wie unauffindbar. Wie läuft die Jagd?', 0),
(203, 'deDE', 'Ich hoffe, Ihr wart erfolgreich, $N. Ohne Eure Hilfe können wir gegen Kurzen nicht lange durchhalten.', 0),
(257, 'deDE', 'Kein Glück gehabt? Macht Euch nix draus, $Ner…$B$BNicht jeder kann so gut sein wie ich.', 0),
(258, 'deDE', 'Es ist ganz normal, dass man sich selbst bemitleidet, wenn man sich vor jemandem blamiert, der so viel jünger ist als man selbst. Macht Euch nichts draus, $Nah…$B$BWie? Hab ich mir Euren Namen falsch gemerkt?', 0),
(267, 'deDE', 'Könnt Ihr mir 8 Troggsteinzähne zeigen? Wenn nicht, dann habt Ihr immer noch etwas zu erledigen, $N.', 0),
(269, 'deDE', 'Ruht Euch erst einmal aus, $GBruder:Schwester;. Ich sehe Euch an, dass Ihr weit gereist seid und eine schwere Bürde tragt. Könnt Ihr mir erzählen, was diesen dunklen Schatten über Euch wirft?', 0),
(275, 'deDE', 'Das Sumpfland weint noch, und die Moorkrabbler wüten noch. Kommt zurück, wenn Eure Aufgabe erledigt ist.', 0),
(276, 'deDE', 'Eure Aufgabe steht noch an, $Gjunger:junge; $C.', 0),
(286, 'deDE', 'Habt Ihr die Statuette?', 0),
(294, 'deDE', 'Tötet 10 Scheckige Raptoren und 10 Scheckige Kreischer, $N. Meine Mitarbeiter haben das Schicksal nicht verdient, das ihnen zuteil wurde. Es ist Zeit die Rechnung zu begleichen.', 0),
(295, 'deDE', 'Ich will, dass diese Scheckigen Sensenklauen und Scheckigen Scharfzähne für ihre Taten bezahlen. Habt Ihr schon 10 von beiden getötet?', 0),
(296, 'deDE', 'Ist Sarlatan tot? Seid Ihr dem Andenken der Gefallenen gerecht geworden?', 0);
