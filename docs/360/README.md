# Effecting centralized logging strategy

WIP

## Logging libraries

- pino

  Could get to work with mongo. Didn't really spend to much time on it.

- winston

  Most popular

## Logging server software

- Loki
- flutend

  Little memory usage and common usage with kubernetes

- ELK stack
- Grafana Loki

## My problem

I am writing an distributed application where there are multiple nodes that may
be scaled up and down. I am looking for a simple centralized logging solution.
Preferably, something that I may run on my local machine. For local development
I am using docker compose. I have found a bunch of SaaS or complicated open
source logging (ELK stack, etc) that is more complicated than I like. I could
just setup a single mongodb instance for logging to keep it simple. I feel like
there should be a simple dedicated tool for logs. Any one know if there is
anything available? See https://zet.jlrickert.me/357 for details of the
application that I am writing.

## Logging levels from RFC 5424

| Numerical Code | Severity                                 |
| -------------- | ---------------------------------------- |
| 0              | Emergency: system is unusable            |
| 1              | Alert: action must be taken immediately  |
| 2              | Critical: critical conditions            |
| 3              | Error: error conditions                  |
| 4              | Warning: warning conditions              |
| 5              | Notice: normal but significant condition |
| 6              | Informational: informational messages    |
| 7              | Debug: debug-level messages              |

- EMERG

  Business critical emergency. All hands on deck and must be fixed asap. 2 AM
  crap.

- FATAL

  Fatal error where the application can no longer run.

- ERROR

  Application error where the application may operate on a degraded stated

- WARN

  Warning indicating that an issue may arise

- INFO

  Basic business info

- DEBUG

  Verbose logging for diagnostic purposes. Typically, this is for developers

- TRACE

  Deep tracing of the application. log all the things. Typically, this is for
  developers.
