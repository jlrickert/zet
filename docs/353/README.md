# AWS EC2

## Load balancing

Basic EC2 load balancing

- ALB (Application load balance)

  - HTTP and HTTPS
  - SSL is offloaded here?
  - Layer 7
  - Support for HTTP/2 and websockets

  - Load balancing method
    - round robbin
    - sticky session
  - features
    - routing based on url
    - redirectes
    - other features such redirecting to lambda

- NLB (network load balancer)

  Connection level load balancing

  - higher performance

  Layer 4

- gateway load balancer

  Third party virtual appliances
