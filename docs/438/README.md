# Project ideas

## jlrickert.me domain

This is a mono repo that houses many of my reusable code and applications for the jlrickert.me domain that I have.

- See [personal website design](../438)
- Public Zettelkasten

  An attempt to virtualise my knowledge. I am finding that there a huge benefit to writing things down. Make it easy to share it with others where it makes sense to.

## Neovim emacs envy

I am starting to find myself doing more and more things in neovim. This is more or less like how the emacs echo system more or less works. Somethings that I need to research is better debug and live editing. Maybe at some point I will look into fennel. Probably not worth the time investment but would be cool.

## knutjs

[knutjs](../439) is a keg app that will replace the way that I take notes and share them. It will integrate with neovim in some way. It would also be nice to be able to edit and add new notes on a web page as I don't always have my laptop handy.

Here are a few key ideas:

- Share a private note via a link

  Often times if I am making plans with friends I create personal node. It would be convenient to be able to share these notes with them. I don't want to make them public as I would like to prevent doxing my friends. Other things to think about is automatic sharing of linked notes. This maybe a bit tricky.

- Some sort of integration with my jlrickert.me domain
- Able to edit notes and view them on my phone in a reasonable amount of time.

  I often times create recipes on my laptop and view them on my phone while cooking. It is sometimes problematic when it takes several minutes for a quick edit to be viewable on my phone.

- Automation

  Overtime I have been noticing patterns that I do quite often. For baking and micro greens I typically maintain and index. The index is simple, a list of a date, a title and a link to a node. This gives me a way to quickly glance

- Spacial representation of time (Calendar)

  Need some way to integrate with google calendar.

## Database mounting program

Mounting a database to the file system to allow dev tools to be used instead of the dumb CMS tools.

## Tapper

KEG manager thingy

## AI Context manager

Stateful command tree for managing stateful objects. Each object can be passed to and LLM to get a output. An object would consist of a role, context, vector database thing and prompt. This should integrate with Tapper and Keg somehow. Ideally, I would like to keep them separate independant tools if at all possible.
