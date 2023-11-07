# Message de-duplication on AWS FIFO topics

Amazon SNS FIFO topics and Amazon SQS FIFO queues support message deduplication,
which provides exactly-once message delivery and processing as long as the
following conditions are met:

- The subscribed Amazon SQS FIFO queue exists and has permissions that allow the
  Amazon SNS service principal to deliver messages to the queue.

- The Amazon SQS FIFO queue consumer processes the message and deletes it from
  the queue before the visibility timeout expires.

- The Amazon SNS subscription topic has no message filtering. When you configure
  message filtering, Amazon SNS FIFO topics support at-most-once delivery, as
  messages can be filtered out based on your subscription filter policies.

- There are no network disruptions that prevent acknowledgment of the message
  delivery.

## See Also

- [SNS](../393)
- [SQS](../392)
- https://docs.aws.amazon.com/sns/latest/dg/fifo-message-dedup.html