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

copy_bashrc() {
	if [[ -f $HOME/.bashrc ]]; then
		echo "Making copy of .bashrc"
		cp "$HOME/.bashrc" "$CUR_DIR/bashrc"
	else
		echo "Could not copy .bashrc: file not found"
	fi
}


copy_zhrc() {
	if [[ -f $HOME/.bashrc ]]; then
		echo "Making copy of .zshrc"
		cp "$HOME/.zshrc" "$CUR_DIR/zshrc"
	else
		echo "Could not copy .zshrc: file not found"
	fi
}

copy_zprofile() {
	if [[ -f $HOME/.bashrc ]]; then
		echo "Making copy of .zprofile"
		cp "$HOME/.zprofile" "$CUR_DIR/zprofile"
	else
		echo "Could not copy .zprofile: file not found"
	fi
}

copy_profile() {
	if [[ -f $HOME/.bashrc ]]; then
		echo "Making copy of .profile"
		cp "$HOME/.profile" "$CUR_DIR/profile"
	else
		echo "Could not copy .profile: file not found"
	fi
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


full() {
	dump_app_list
	copy_bashrc
	copy_zhrc
	copy_profile
	copy_zprofile
	copy_display_profiles
	dump_brew_formulas
	dump_brew_casks
	dump_brew_taps
}

check_export_dir_here

case "$1" in
	full | all)
		full;;
	apps)
		dump_app_list;;
	bashrc)
		copy_bashrc
		;;
	zshrc)
		copy_zhrc
		;;
	display)
		copy_display_profiles
		;;
	profile)
		copy_profile
		;;
	zprofile)
		copy_zprofile
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
END
	;;
esac
