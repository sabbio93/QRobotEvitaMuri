# Disclaimer
Questo documento è pensato per dare un riferimento all'utilizzo del Rover **swagbot**.

# $SwagBot$
Il robot Cassetta si chiama Pietro, è del prof e torerà indietro.

#### Struttura
Il corpo del robot è composto da un contenitore per VHS senza copertina (sarebbe stato più trash, peccato).
Ha due route posteriori collegate ad incastro a due motori continui.
è sorretto anteriormente da una sfera di metallo.

I due motori sono pilotati, tramite un ponte H, da un RaspberryPi 2.
L'unico sensore del robot è un sonar HC-SR01, collegato anteriormente.
Il RaspberryPi è alimentato da una powerbank.

#### Accesso al RaspberryPi
Si può accedere tramite wifi/ethernet

|Modalità | Username | Password     | Indirizzo |
|  :------------- | :------------- | :------------- |  :------------- |
| SSH | pi       | raspberry       | `local_address:22` |
|  Web terminal | | |          `https://local_address:4200` |
|VNC Remote Desktop | | 123456     | `local_address:1` |
|SMB Network Share | | |      `\\local_address\home_pi\` |

#### Collegamenti

| Componente | Sequenza fili, da sinistra verso destra |  
| :------------- | :------------- |
| Sonar       | Marrone, Rosso, Arancione, Giallo1       |
| PonteH       | Giallo2, Verde, Blu, Viola, Grigio, Bianco       |

Giallo2 è sulla linea più interna del raspberry
Giallo1 è sulla linea più esterna del raspberry

| Filo | PinGPIO (Fisico) | PinGPIO (BCM) | PinGPIO (WiPi) | Tipologia | Cosa Fa |
| :-------- | :------- | :------ | :------- | :------ |  :------ |
| Blu       | 2  | -  | -  | 5V  | Alimenta PonteH |
| Giallo1   | 4  | -  | -  | 5V  | Alimenta Sonar |
| Marrone   | 6  | -  | -  | GND | Ground Sonar |
| Verde     | 3  | 2  | 8  | OUT | Ruota sinistra avanti |
| Giallo2   | 5  | 3  | 9  | OUT | Ruota sinista indietro |
| Viola     | 9  | -  | -  | GND | PonteH Ground |
| Arancione | 11 | 17 | 0  | OUT | Sonar Trig |
| Rosso     | 13 | 27 | 2  | IN  | Sonar Echo |
| Bianco    | 19 | 10 | 12 | OUT | Ruota destra indietro |
| Grigio    | 21 | 9  | 13 | OUT | Ruota destra avanti |

#### SwagBot.baseddr

```
RobotBase swag

distancefront = Distance [ sonarhcsr04 pintrig 0 pinecho 2] position: FRONT_TOP

motorleft = Motor [ gpiomotor pincw 9 pinccw 8] position: LEFT
motorright = Motor [ gpiomotor pincw 12 pinccw 13] position: RIGHT

motors = Actuators [ motorleft, motorright] position: BOTTOM

Mainrobot swag [motors];
```
