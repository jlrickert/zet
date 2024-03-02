# Java 16.02 bug with AMD processors

Learned about a bug that Thor had about his Minecraft server on 2024-02-27. Turns out that the number of threads was not being detected as expected. Only 1 thread was detected when there are actually 24. This only occurs when using Java 16.02 with an AMD processor in a container. Some one in chat also mentioned that they had a similar issue related to cgroups. Missed most of the details though as I was not able to find it again in the chat history.
