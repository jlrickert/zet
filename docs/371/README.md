# Reactivity concepts in web development

Reactivity comes in a bunch of different flavors. The ones that I know of are
sinals and observables.

## Signals

Signals have 3 different things:

- value
- computed
- effect

A value is simple some value. A computed value is a value computed from other
values. When a value changes everything inside of an effect is ran. A computed
value can be thought of as a compound value. However, a value is not meant to be
directly modified. There is an optimization for computed values where it is not
unless there is an effect that depend on it.

This is similar to observables. However, observable values are not available to
the outside world and are stuck inside the monad.
