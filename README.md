# tube

What to gawk on the tube?!

## Introduction

**tube** shows current and prime time german television schedule. The needed
information is gathered from https://texxas.de

## Installation

    $ gem build
    $ gem install tube-$(ruby -Ilib -e 'require "tube/version"; puts Tube::VERSION').gem

## Usage

    $ tube shows --category sports
    CHANNEL        SHOW                                 STARTED
    ───────────────────────────────────────────────────────────
    SPORT1         Fußball - 2. Liga Live - Vorberichte 19:30
    SPORT1+        Baseball - MLB Regular Season        18:25
    Eurosport 1    Weltmeisterschaft in Les Gets        19:45
    Eurosport 2    La Vuelta 2022                       19:00
    Sky Sport News Live Sky Sport News                  19:30
    DAZN           LaLiga                               19:30
    eSports1       eSports - NBA 2K League              17:35

    7 shows listed.

For further information about the command line tool `tube` see the following
help output.

    Usage:
        tube [OPTIONS] SUBCOMMAND [ARG] ...

    Parameters:
        SUBCOMMAND       subcommand
        [ARG] ...        subcommand arguments

    Subcommands:
        shows            list current shows

    Options:
        -h, --help       print help
        -m, --man        show manpage
        -v, --version    show version

## License

[GNU General Public License v3.0.](https://www.gnu.org/licenses/gpl-3.0.en.html)

## Is it any good?

[Yes.](https://news.ycombinator.com/item?id=3067434)
