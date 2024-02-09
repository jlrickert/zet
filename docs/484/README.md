# Rock paper scissors game

```ts
const Choice = "rock" | "paper" | "scissors";
const Winner = "1" | "2" | 'draw';

const Scenarios: Record<Choice, Record<Choice, Winner>> = {
  "rock": {
    "rock": "tie"
    "paper": "2"
    "scissors": "1"
  },
  "paper": {
    "rock": "1"
    "paper": "tie"
    "scissors": "2"
  },
  "scissors": {
    "rock": "2"
    "paper": "1"
    "scissors": "tie"
  }
} satisfies {}

const rps = (p1: Choice, p2: Choice): Winner => {
  if (p1 === p2) {
    return "draw"
  }
  if (p1) {}
};
```