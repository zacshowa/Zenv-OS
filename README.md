# Zenv-OS
This repo contains the NixOS configuration that I use to run my dev environment, as well as my dotfiles that are managed in part by home-manager.
These dotfiles are maintained in a separate repo, but it's not easy to use submodules as inputs to a nix flake (at least that's not what I want to spend my time on right now)
For now, this means that these are maintained independently from the dotfile repo, but I will be keeping them in sync.

How did I come up with this name you might ask? There are a few factors.

- 1: I quite like the letter Z. Yes I'm biased, sue me.

- 2: This is meant to be a NixOS configuration for a development ENVironment.

- 3: It was much harder to find something that rolled off the tongue that included a D in the mnemonic for development environment.

- 4: A mentor once semi-jokingly told me "Naming is the hardest problem in computer science." Given this axiom, and the fact that this project has more urgent needs than the perfect name,
     I decided that this was good enough :)

## Attributions

Everything I have ever learned, will learn, and will one day forget about computers has been because of the mentors that I have been exceedingly lucky to have in my life.
Many people have expressed a similar idea over hundreds of years, potentially as far back as the middle ages (if one chooses to believe [Wikipedia](https://en.wikipedia.org/wiki/Standing_on_the_shoulders_of_giants#Middle_Ages) at the time of writing).
One that has been most famously attributed to Isaac Newton in the following form "If I have seen further, it is by standing on the shoulders of Giants".
I've often found this quote resonates with me deeply, and I feel as though I must always pay my respects to the knowledge and skills I have gained due to the legacies of the giants of computing.

These names are in no particular order, is non-exhaustive, and is subject to change as others contributions to my knowledge of this engineering discipline help to evolve my practice of it, their names will be added here in kind.

- Jason Mckenna: For introducing me to programming with Lego Mindstorm robots.
- Brian Rogoff: For being a life raft in raging, ghostly waters, and introducing me to Nix/NixOS.
- Mathis Antony: For teaching me most of what I know about Nix dev environments, NixOS, and general contributions to my growth as an engineer.
- Marc Brinkmann: For teaching me all that he knew about Async Rust, and showing me that I have what it takes to be a systems engineer.
- Frasier Hutchinson: For showing me that rigor is best paired with endless humility.
- Manuel Blum: For introducing me to Alice and Bob, whose hash functions cannot be broken by measly machines.
- Ancients & Bab: For the endless help with infrastructure, and always advocating for me.
- Jeb Bearer: For being a lighthouse through the storm, and reminding me what to be passionate about.
- Luke Ianucci: For showing me new ways to tackle problems, and reminding me that others know when I pour my soul into something.
- Jean Gal: For helping evolve my humor and resilience in the face of hardship, no matter how great.
- Jeremy He: For showing me what incredible technical speed looks like
- Sneh Koul: For being an excellent leader during the most uncertain times.


## Contributing:
Any contributions are welcome via PR's, but my will, as the BDFL of this project, will be the deciding factor, at least for now. IDK what happens if other people start using this for real.
That is to say, This remains subject to change at the BDFL's discretion at any time until such a change changes this proceedure.

(I'll change this to a more formal process once the repo is more established, I'm just tired of not being able to track this with git.)

## Known issues.
During the initial commit, I want to track known issues, so that they can be turned into actual git issues in the repo, Once these are captured, this will be removed from the readme.

### Multiple monitors
  Currently, multiple monitors don't seem to work for my setup with this config
  I'm trying to run it through a thunderbolt dock and then through displayport 1.4. It seems as thought the OS manages to detect the monitor, an even address it correctly when switching workspaces, but I get no proper display out.
  It usually gets 1 frame during a reload/rebuild, then will be frozen on that frame forever, despite the fact that I can open programs in the workspace bound to that display.

  My current hypothesis is that this has something to do with having an Nvidia GPU. More documentation will be written about this in the issue.

### File Structure
  The file structure is currently held together with a judicious amount of elmers glue, duct tape, and prayers. Not really, but I think many things could be isolated to their own files to employ some separation of concerns.
  I also want to move most installed packages to be installed with home-manager, rather than at a system level. The intention is to keep the base system relatively light, as it's likely to be used for working on projects that utilize nix flakes and direnv.
  This means that many packages won't need to be installed at a system level.
