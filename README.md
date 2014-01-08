AB0-Simulator
-------------

Der AB0-Simulator simuliert die Entwicklung einer Verteilung von
Blutgruppen nach AB0-System, wie es in der Wikipedia unter

http://de.wikipedia.org/wiki/AB0-System#Vererbung

beschrieben ist. Der Code macht keine weiteren (biologischen)
Annahmen.

Eine "Verteilung" ist ein 4-Tupel von Wahrscheinlichkeiten für die
vier Blutgruppen A, B, AB und 0. Die Summe der vier
Einzelwahrscheinlichkeiten muss jeweils 100 Prozent ergeben. Eine
Ausgangsverteilung lässt sich beispielsweise so definieren:

my $deutsch = {
  O  => 0.41,
  A  => 0.43,
  B  => 0.11,
  AB => 0.05
};

Eine Verteilung ist die zentrale Datenstrur des Simulators (Innerhalb
des kompletten Codes wird das Symbol "O" (großes O) statt der Ziffer
"0" (Null) verwendet, wie dies im anglo-amerikanischen Sprachraum
üblich ist).

Der Simulator definiert drei Funktionen:

print_configuration($distribution)

Gibt "$distribution" auf Stdout einzeilig aus. Als Besonderheit
korrigiert die Funktion den Wert für die Blutgruppe AB, falls die
Summe der Einzelwahrscheinlichkeiten nicht 100 Prozent beträgt. In dem
Fall gibt die Funktion einen Hinweis aus. Würde diese Behandlung
ausgelassen, ergäben sich aufgrund von Kaskadeneffekten nach wenigen
Generationen erhebliche Rundungsfehler.

$new_distribution = generation($distribution)

Führt die Verteilung "$distribution" in "$new_distribution" auf
Grundlage der in der Wikipedia hinterlegten und im komplexen Hashref
"$t" über.

Die Funktion macht die Annahme, dass die Elternteile ihre jeweiligen
Partner nicht auf Grundlage der Blutgruppe des Partners
auswählen. Insofern gibt es 4 * 4 = 16 Elternkonfigurationen (codiert
in der Variable "$comb"). Wie groß die Anteile dieser 16 Kombinationen
innerhalb der Gesamtpopulation sind, ergibt sich aus der
Wahrscheinlichkeit der Blutgruppe der Mutter und der des Vaters.

Laut Wikipedia-Tabelle gehen aus so einem Elternpaar mit verschiedenen
Wahrscheinlichkeiten Kinder unterschiedlicher Blutgruppen hervor. Der
Simulator sucht diese Wahrscheinlichkeiten heraus und gewichtet sie
mit der Präsenz der Eltern in der Vorgeneration.

simulate($headline, $distribution, $iterations)

Die Funktion iteriert den Prozess ausgehen von der Verteilung
"$distribution" insgesamt "$iterations" Male. Für jede Iteration gibt
sie die aktuelle Verteilung aus. Vor diese Ausgabe setzt sie eine
Überschfrift mit dem Inhalt von "$headline".

Diese Software ist Copyright (c) 2014 by Nils Magnus (magnus@linuxtag.org)

Sie ist freie Software und lizensiert unter der GPLv2.
