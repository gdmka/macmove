# Macmove

Macmove is a utility that helps to move crucial config from one Mac to another. It is useful when Time Machine backup is unavailable or impossible (think Intel to M1/M2 migration).

## Features

Currently Macmove can:

* Copy crucial dotfiles (`.profile`, `.bashrc` and `zsh` related dotfiles)
* Create a list of installed apps both active user wide and system wide
* Copy `.icc` display profiles folder
* Create a list of `brew` specific data: installed formulas, taps and casks
  
Gathered data is put to `Macmoved` folder.

## Usage

    ./macmove.sh [command]
	apps — populate list of installed apps
	bashrc  — copy .bashrc file
	profile — copy .profile file
	zshrc — copy .zshrc file
	zprofile — copy .zprofile file
	display — copy directory containing all .icc profiles
	casks — populate list of installed casks
	taps — populate list of added brew taps
	formulas — populate list of installed formulas
	full | all - perform all actions listed above as one

## Contributions

Pull requests are welcome!
