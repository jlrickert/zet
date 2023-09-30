# Battle tanks the game

Battle Tanks is a simple multiplayer game that I am building as a means to learn
about distributed systems and AWS. For production deployment it would be ideal
for game servers to be added and removed based on demand. There should be a
lobby that allows players to find be able to join servers that are available.

## Architecture

For development I prefer being able to develop on my local machine. I plan on
using `traefik` for load balancing and docker compose.

![Game Architecture](game-architecture.png)
![Game Architecture](game-architecture-2.png)
