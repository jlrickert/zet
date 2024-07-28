# Service announcement protocols

- NetBIOS-NS

  Legacy NetBIOS name server. Advertises the SMB service NetBIOS Name. Can be required for legacy SMB1 clients to discover the server. When advertised, the server appears in Network Neighborhood).

- mDNS

  Multicast DNS. Uses the system Hostname to advertise enabled and running services. For example, this controls if the server appears under Network on MacOS clients.

- WS-Discovery

  Uses the SMB Service NetBIOS Name to advertise the server to WS-Discovery clients. This causes the computer appear in the Network Neighborhood of modern Windows OSes.