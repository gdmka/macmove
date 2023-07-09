#! /bin/bash

set -o errexit

CUR_DIR="$(pwd)/Macmoved"

check_export_dir_here(){
	if ! [[ -d "$CUR_DIR" ]]; then
		mkdir -p "$CUR_DIR"
	fi
}

dump_app_list() {
	echo "Dumping list of installed apps"
	# Make sure to get system wide installations and user only
	sort -u <(ls  /Applications) <(ls "$HOME/Applications") > "$CUR_DIR/installed_apps.txt"
}

copy_display_profiles() {
	echo "Copying Display profiles"
	cp -r "/Library/ColorSync/Profiles/Displays" "$CUR_DIR"
}

dump_brew_formulas() {
	echo "Dumping list of brew packages"
	brew list --formula --version > "$CUR_DIR/brew_packages.txt"
}

dump_brew_casks() {
	echo "Dumping list of brew casks"
	brew list --casks -1 > "$CUR_DIR/brew_casks.txt"

}

dump_brew_taps() {
	echo "Dumping list of brew taps"
	brew tap > "$CUR_DIR/brew_taps.txt"
}

copy_dotfiles() {
	echo "Copying dotfiles"
	for dot in $(find $HOME -maxdepth 1 -name ".*" -type f -and -not -name ".DS_Store" -and -not -type s); do cp "$dot" "$CUR_DIR"; done
}

copy_dotfolders() {
	echo "Copying dotfolders"
	for dotf in $(find $HOME -maxdepth 1 -name ".*" -type d  \( ! -type f -and -name "*sock" -a ! -type s \) -and -not -name ".Trash"); do cp -Rp "$dotf" "$CUR_DIR"; done
}


full() {
	dump_app_list
	copy_display_profiles
	dump_brew_formulas
	dump_brew_casks
	dump_brew_taps
	copy_dotfiles
	copy_dotfolders
}

check_export_dir_here

case "$1" in
	full | all)
		full
		;;
	apps)
		dump_app_list
		;;
	dotfiles)
		copy_dotfiles
		;;
	dotfolders)
		copy_dotfolders
		;;
	display)
		copy_display_profiles
		;;
	casks)
		dump_brew_casks
		;;
	formulas)
		dump_brew_formulas
		;;
	taps)
		dump_brew_taps
		;;
	*) cat <<END
Usage:
$0 [command]
	apps — populate list of installed apps
	dotfiles  — copy all dotfiles found in '$HOME'
	dotfolders — copy all dotfolders found in '$HOME' recursively
	display — copy directory containing all .icc profiles
	casks — populate list of installed casks
	taps — populate list of added brew taps
	formulas — populate list of installed formulas
	full | all - perform all actions listed above as one
END
	;;
esac
