# Hardware: TP-Link BE550 (be550)

WIFI7 router with 5 2.5G Ethernet ports.

Management is done through <http://tplinkwifi.net/>. How???

## Configuration:

- Multi-Link Operation (MLO) is on

Current SSID:

- ravnet
- ravnet-6G
- ravnet-iot
- ravnet-iot-5G
- ravnet-mlo

## Benchmarks

All measurements are Mbits/Sec

| Client           | Server          | Bandwidth 1 | Bandwidth 2 | Bandwidth 3 | Avg  |
| ---------------- | --------------- | ----------- | ----------- | ----------- | ---- |
| Desk S22+ 6G     | Desk MBP 6G     | 477         | 190         | 325         | 330  |
| Desk S22+ 6G     | Desk MBP 2.4/5G | 578         | 510         | 504         | 530  |
| Desk S22+ 2.4/5G | Desk MBP 6G     | 636         | 286         | 536         | 486  |
| Desk S22+ 2.4/5G | Desk MBP 2.4/5G | 213         | 411         | 401         | 341  |
| Desk S22+ 2.4/5G | Desk MBP eth    | 674         | 654         | 723         | 683  |
| Desk S22+ 6G     | Desk MBP eth    | 593         | 670         | 636         | 633  |
| Deck S22+ 6G     | Desk MBP eth    | 19.7        | 32.0        | 35.8        | 29.2 |
| Deck S22+ 2.4/5G | Desk MBP eth    | 142         | 158         | 146         | 149  |
| Deck MBP 6G      | TS140           | 108         | 145         | 82          |      |
| Deck MBP 2.4/5G  | TS140           | 255         | 236         | 234         |
| Deck MBP MLO     | TS140           | 122         | 260         | 260         |
| Desk MBP MLO     | TS140           | 825         | 861         | 841         |
| Desk MBP 6G      | TS140           | 536         | 557         | 764         |
| Desk MBP eth     | TS140           | 852         | 855         | 852         |
| Desk MBP eth     | TS140 2.5G      | 781         | 781         | 781         |
| Desk MBP 6G      | TS140 2.5G      | 818         | 810         | 824         |      |
| Desk MBP eth     | trooper 2.5G    | 994         | 941         | 941         |
| Desk MBP 2.4/5G  | trooper 2.5G    | 1240        | 1310        | 1290        |
| Desk MBP 6G      | trooper 2.5G    | 893         | 550         | 1250        |
| Desk MBP 6 MLO   | trooper 2.5G    | 1300        | 1330        | 1290        |
| TS140            | Trooper         | 2340        | 2350        | 2333        |
| ns1              | ns2             | 23300       |

## See also

For for information see private [notes](keg:private/1124).
