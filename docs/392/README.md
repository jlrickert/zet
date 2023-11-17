# Simple Queue Service (SQS)

SQS is a managed service on AWS. It allows decoupling different systems. Think
batching.

- Standard Queue

  Best effort to maintain order of messages

- FIFO Queue

  Guaranties order of messages

- Features

  - Dead letter queue

    Messages that have failed to be processed are sent here.

  - Long polling

    Allows for a high volume of messages. Things can be scaled up by adding more
    consumers for data in the queue.

  - Message groups

## See also

- [AWS Services](../391)

## Meta

    tags: #aws