INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606413127246360900');

DELETE FROM `achievement_reward_locale` WHERE `ID` IN (4785, 4784, 4602, 4603, 4156, 3957, 4079, 3857, 2958, 2957, 2537, 2796, 2536, 2136, 1681, 1682, 876, 619) AND `locale` = 'deDE';
INSERT INTO `achievement_reward_locale` (`ID`, `Locale`, `Subject`, `Text`) VALUES
(4785, 'deDE', 'Emblem Rüstmeister in Dalaran''s Sonnenhäschers Zuflucht', 'Eure Erfolge in Nordend sind nicht unbemerkt geblieben, Freund.$B$BDie verdienten Embleme können benutzt werden, um Gegenstände bei den verschiedenen Rüstmeistern für Embleme zu kaufen.$B$BIhr findet uns in Sonnenhäschers Zuflucht, wo jede Emblemart einen eigenen Rüstmeister hat.$B$BWir freuen uns auf Eure Ankunft!'),
(4784, 'deDE', 'Emblem Rüstmeister in Dalaran''s Silbernen Enklave', 'Eure Erfolge in Nordend sind nicht unbemerkt geblieben, Freund.$B$BDie verdienten Embleme können benutzt werden, um Gegenstände bei den verschiedenen Rüstmeistern für Embleme zu kaufen.$B$BIhr findet uns in der Silbernen Enklave, wo jede Emblemart einen eigenen Rüstmeister hat.$B$BWir freuen uns auf Eure Ankunft!'),
(4602, 'deDE', 'Ruhm des Schlachtzüglers von Eiskrone', '$N,$B$BAls der Einfluss des Lichkönigs schwand, haben sich einige seiner mächtigeren Schergen aus seinem Griff befreit.$B$BDieser von meinen Männern gefangen genommene Frostwyrm Drache ist ein Paradebeispiel dafür. Sie hat einen eigenen Willen und noch mehr.$B$BEiner meiner Männer verlor einen Arm als er sie einritt, aber sie kann jetzt recht gut mit Reitern umgehen - vorausgesetzt Ihr seid geschickt und habt einen starken Willen.$B$BBitte nehmt diese prächtige Bestie als Geschenk der Ritter der Schwarzen Klinge an. Es war mir eine Ehre, an Eurer Seite in der größten aller Schlachten zu kämpfen.$B$BHochachtungsvoll,$BDarion Mograine.'),
(4603, 'deDE', 'Ruhm des Schlachtzüglers von Eiskrone', '$N,$B$BAls der Einfluss des Lichkönigs schwand, haben sich einige seiner mächtigeren Schergen aus seinem Griff befreit.$B$BDieser von meinen Männern gefangen genommene Frostwyrm Drache ist ein Paradebeispiel dafür. Sie hat einen eigenen Willen und noch mehr.$B$BEiner meiner Männer verlor einen Arm als er sie einritt, aber sie kann jetzt recht gut mit Reitern umgehen - vorausgesetzt Ihr seid geschickt und habt einen starken Willen.$B$BBitte nehmt diese prächtige Bestie als Geschenk der Ritter der Schwarzen Klinge an. Es war mir eine Ehre, an Eurer Seite in der größten aller Schlachten zu kämpfen.$B$BHochachtungsvoll,$BDarion Mograine.'),
(4156, 'deDE', 'Ein Tribut an die Unsterblichkeit', '$GLieber:Liebe; $N,$B$BGeschichten über Eure jüngste Leistung in der Prüfung des obersten Kreuzfahrers werden noch lange Zeit erzählt und nacherzählt werden. Als der Argentumkreuzzug die größten Meister von Azeroth aufrief ihren Kampfgeist im Schmelztiegel des Kolosseums zu erproben, hoffte ich wider Erwarten, dass Leuchtfeuer wie Ihr und Eure Gefährten aus dem Kampf hervorgehen würden.$B$BWir werden Euch in der kommenden Schlacht gegen den Lichkönig dringend brauchen. Aber an diesem Tag solltet Ihr Euch freuen und Eure ruhmreiche Leistung feiern und dieses Geschenk eines unserer besten Schlachtrösser annehmen. Wenn die Geißel ihr Banner am Horizont auftauchen sieht, Held, wird ihr Ende nahe sein!$B$BMit freundlichen Grüßen,$BTirion Fordring'),
(3957, 'deDE', 'Meister der Insel der Eroberung', '$GEhrenvoller:Ehrenvolle; $N,$B$BFür Eure Taten auf der Insel der Eroberung ist es mir eine Ehre Euch diesen Wappenrock zu überreichen. Tragt ihn mit Stolz.$B$BOberanführer Agmar'),
(4079, 'deDE', 'Ein Tribut an die Unsterblichkeit', '$GLieber:Liebe; $N,$B$BGeschichten über Eure jüngste Leistung in der Prüfung des obersten Kreuzfahrers werden noch lange Zeit erzählt und nacherzählt werden. Als der Argentumkreuzzug die größten Meister von Azeroth aufrief ihren Kampfgeist im Schmelztiegel des Kolosseums zu erproben, hoffte ich wider Erwarten, dass Leuchtfeuer wie Ihr und Eure Gefährten aus dem Kampf hervorgehen würden.$B$BWir werden Euch in der kommenden Schlacht gegen den Lichkönig dringend brauchen. Aber an diesem Tag solltet Ihr Euch freuen und Eure ruhmreiche Leistung feiern und dieses Geschenk eines unserer besten Schlachtrösser annehmen. Wenn die Geißel ihr Banner am Horizont auftauchen sieht, Held, wird ihr Ende nahe sein!$B$BMit freundlichen Grüßen,$BTirion Fordring'),
(3857, 'deDE', 'Meister der Insel der Eroberung', '$GEhrenvoller:Ehrenvolle; $N,$B$BFür Eure Taten auf der Insel der Eroberung ist es mir eine Ehre Euch diesen Wappenrock zu überreichen. Tragt ihn mit Stolz.$B$BHochkommandant Halford Wyrmbann, 7. Legion'),
(2958, 'deDE', 'Heroisch: Ruhm des Schlachtzüglers von Ulduar', '$GLieber:Liebe; $N,$B$BIch hoffe, dass es Euch gut geht und dass Ihr Zeit hattet Euch von unseren Mätzchen in Ulduar zu erholen.$B$BMeine Jungs vom Erkundungsteam sind auf dieses arme halbtote Reitdrachen-Jungtier gestoßen. Das muss eine Art Experiment der Eisenzwerge gewesen sein.$B$BWir haben es wieder gesund gemacht und Ihr werdet feststellen, dass es nicht mehr so klein ist! Keiner von uns weiß viel über das Reiten von etwas anderem als Widdern und Maultieren und da wir euch für das was ihr da hinten gemacht habt etwas schuldig sind... Wir dachten Ihr würdet es vielleicht als Geschenk annehmen.$B$BEuer Brann Bronzebart'),
(2957, 'deDE', 'Ruhm des Schlachtzüglers von Ulduar', '$GLieber:Liebe; $N,$B$BIch hoffe, dass es Euch gut geht und dass Ihr Zeit hattet Euch von unseren Mätzchen in Ulduar zu erholen.$B$BMeine Jungs vom Erkundungsteam sind auf dieses arme halbtote Reitdrachen-Jungtier gestoßen. Das muss eine Art Experiment der Eisenzwerge gewesen sein.$B$BWir haben es wieder gesund gemacht und Ihr werdet feststellen, dass es nicht mehr so klein ist! Keiner von uns weiß viel über das Reiten von etwas anderem als Widdern und Maultieren und da wir euch für das was ihr da hinten gemacht habt etwas schuldig sind... Wir dachten Ihr würdet es vielleicht als Geschenk annehmen.$B$BEuer Brann Bronzebart'),
(2537, 'deDE', 'Tierisch viele Reittiere', 'Ich habe gehört, dass Eure Ställe inzwischen fast so groß sind wie meine. Beeindruckend! Vielleicht könnten wir einander aushelfen...$B$BIch habe einen Drachenfalken zuviel und hoffe, dass Ihr ihm ein neues Zuhause geben könnt. Natürlich ist es zum Reittier und nicht zum Jagdtier ausgebildet worden und Ihr werdet sehen, dass es Euch genauso loyal und unermüdlich wie jedes meiner anderen Tiere zur Seite stehen wird.$B$BMit freundlichen Grüßen,$BMei'),
(2796, 'deDE', 'Willkommen im Club Bier des Monats e.V.!', '$N,$B$BWillkommen im Club Bier des Monats e.V.! Dieser Club hat es sich zur Aufgabe gemacht Euch einige der besten Biere der Welt anzubieten. $B$BJeden Monat wird Euch ein neues Gebräu zugeschickt. Wenn Euch dieses Gebräu gefällt und Ihr noch mehr davon wollt, sprecht einfach mit den Mitgliedern des Bier des Monats e.V..$B$BNochmals, willkommen im Club, $N.$B$B- Bier des Monats e.V.'),
(2536, 'deDE', 'Tierisch viele Reittiere', 'Ich habe gehört, dass Eure Ställe inzwischen fast so groß sind wie meine. Beeindruckend! Vielleicht könnten wir einander aushelfen...$B$BIch habe einen Drachenfalken zuviel und hoffe, dass Ihr ihm ein neues Zuhause geben könnt. Natürlich ist es zum Reittier und nicht zum Jagdtier ausgebildet worden und Ihr werdet sehen, dass es Euch genauso loyal und unermüdlich wie jedes meiner anderen Tiere zur Seite stehen wird.$B$BMit freundlichen Grüßen,$BMei'),
(2136, 'deDE', 'Ruhm des Helden', 'Held,$B$BErzählungen der großen Taten, die Ihr seit eurem Eintreffen in Nordend vollbracht habt, sind bis zum Wyrmruhtempel vorgedrungen.$B$BEure Tapferkeit soll nicht unbemerkt bleiben. Bitte aktzeptiert dieses Geschenk im Namen der Aspekte. Mögen wir zusammen Azeroth ein für alle Mal vom Bösen befreien.$B$BAlexstrasza, die Lebensbinderin'),
(1681, 'deDE', 'Grüße aus Darnassus', 'Eure Erfolge waren tiefgreifend und weitreichend. Azeroth profitiert bei den jüngsten Tumulten in großem Maße von jenen, die das Land vom Bösen zu befreien suchen.$B$BNur diejenigen, die sich die Zeit nehmen, unser Land kennen zu lernen, verstehen das Opfer der Gefallenen und den Wert unserer Helden. Ihr seid ein solcher Held. Hoffentlich werdet Ihr Euch noch in vielen Jahren an die Geschichten Eurer Abenteuer erinnern können.$B$BIm Namen der Allianz danke ich Euch, Meister der Lehren.'),
(1682, 'deDE', 'Grüße aus Donnerfels', 'Eure Erfolge waren tiefgreifend und weitreichend. Azeroth profitiert bei den jüngsten Tumulten in großem Maße von jenen, die das Land vom Bösen zu befreien versuchen.$B$BNur diejenigen, die sich die Zeit nehmen, unser Land kennen zu lernen, verstehen das Opfer der Gefallenen und den Wert unserer Helden. Ihr seid ein solcher Held. Hoffentlich werdet Ihr Euch noch in vielen Jahren an die Geschichten Eurer Abenteuer erinnern können.$B$BHabt Dank, Meister der Lehren.$B$BFür die Horde!$B$B--Cairne Bluthuf'),
(876, 'deDE', 'Brutaler Kämpfer', 'Ihr habt ein ganz schönes Händchen dafür Euch in diese Arena zu werfen. Behaltet das bei. Tragt es mit Stolz. Jetzt geht wieder rein und zeigt ihnen, wie es gemacht wird! $B$BOnkel Sal'),
(619, 'deDE', 'Für die Horde!', 'In Zeiten großer Unruhen erheben sich wahre Helden aus dem Elend. Ihr seid ein solch großer Held.$B$BDer Krieg steht vor der Tür. Eure Bemühungen werden unsere Sache in Azeroth voranbringen. Eure großen Taten werden belohnt werden. Nehmt diese Belohnung von Orgrimmar und reitet zum Ruhm.$B$BFür die Horde!$B$BKriegshäuptling Thrall');
