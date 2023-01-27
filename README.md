# OneRotor_Enigma
#Italian: 
Macchina Enigma a singolo rotore riprodotta su Nexys A7 50T.
Il progetto è state implementato per l'esame di Architettura dei sistemi Digitali (prof: Mazzocca-De Benedictis) attravarso il linguaggio vhdl e si è cercato di riprodurre il più fedelmente possibile il funzionamento meccanico della macchina.
E' possibile usare una tastiera per dare l'input alla macchina da codificare, e tale tastiera può essere usata anche come plugboard (basta cambiare la connessione pressione-lettera).Dunque l'unica semplificazione usata per riprodurre enigma è stata l'uso di un singolo rotore, ma questo non toglie che possa essere estesa, presentado il progetto una struttura modulare.

Per cifrare(o decifrare) bisogna passare per i seguenti passi: 

1) Premere il pulsante di start 
2) premere una lettera dalla tastiera
3) cliccare il pulsante di cifratura 
4) Per avviare una nuova cifratura premere il pulsante di nuova cifratura (differete dal pulsante di cifratura)

Nella Repository sono forniti i soli file vhdl 

#English: 
Enigma machine, implemented on Nexys A7 50T.
The project has been implemented for Architecture of Digital System exam (prof: Mazzocca-De Benedictis) by using vhdl language, i tried to reply, as fithfully as possible the machanic operation that the machine does in reality. 
It's possible to use a keyboard to give the input to cypher, and the keyboard can be used as plugboard ( you only need to change the connection between press-key). So the only facilitation that we is that the machine works with only one rotor but maybe in the future you can extend it with more rotors, because i tried to make the project as modular as possible.

To cypher(or de-cypher) you need to walk trought the following steps: 

1) Press the start button
2) Press a key on the keyboard
3) Press the cypher button
4) To start a new cypher process click the new cypher button (differet from cypher)

Into the repository are provided only the vhdl files
