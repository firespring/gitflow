#!/bin/bash

# git-flow make-less installer for *nix systems, by Rick Osborne
# Based on the git-flow core Makefile:
# http://github.com/petervanderdoes/gitflow/blob/master/Makefile

# Licensed under the same restrictions as git-flow:
# http://github.com/petervanderdoes/gitflow/blob/develop/LICENSE

# Updated for the fork at petervanderdoes

usage() {
	echo "Usage: [environment] gitflow-installer.sh [install|uninstall] [stable|develop]"
	echo "Environment:"
	echo "   PREFIX=$PREFIX"
	echo "   REPO_HOME=$REPO_HOME"
	echo "   REPO_NAME=$REPO_NAME"
	exit 1
}

# Does this need to be smarter for each host OS?
if [ -z "$PREFIX" ] ; then
	PREFIX="/usr/local"
elif [ "$PREFIX" == "/"] ; then
  PREFIX=""
fi

if [ -z "$REPO_NAME" ] ; then
	REPO_NAME="gitflow"
fi

if [ -z "$REPO_HOME" ] ; then
	REPO_HOME="https://github.com/petervanderdoes/gitflow.git"
fi

EXEC_PREFIX="$PREFIX"
BINDIR="$EXEC_PREFIX/bin"
DOCDIR="$PREFIX/local/share/doc/gitflow"

EXEC_FILES="git-flow"
SCRIPT_FILES="git-flow-init git-flow-standalone-story git-flow-feature git-flow-story git-flow-hotfix git-flow-release git-flow-support git-flow-version gitflow-common gitflow-shFlags git-flow-config"
HOOK_FILES="$REPO_NAME/hooks/*"


echo "### git-flow no-make installer ###"

case "$1" in
uninstall)
	echo "Uninstalling git-flow from $PREFIX"
	if [ -d "$BINDIR" ] ; then
		for script_file in $SCRIPT_FILES $EXEC_FILES ; do
			echo "rm -vf $BINDIR/$script_file"
			rm -vf "$BINDIR/$script_file"
		done
		rm -rf "$DOCDIR"
	else
		echo "The '$BINDIR' directory was not found."
	fi
	exit
	;;
help)
	usage
	exit
	;;
install)
	if [ -z $2 ]; then
		usage
		exit
	fi
	echo "Installing git-flow to $BINDIR"
	if [ -d "$REPO_NAME" -a -d "$REPO_NAME/.git" ] ; then
		echo "Using existing repo: $REPO_NAME"
	else
		echo "Cloning repo from GitHub to $REPO_NAME"
		git clone "$REPO_HOME" "$REPO_NAME"
	fi
	case "$2" in
	stable)
		cd "$REPO_NAME"
		git checkout master
		cd "$OLDPWD"
		;;
	develop)
		cd "$REPO_NAME"
		git checkout develop
		cd "$OLDPWD"
		;;
	*)
		usage
		exit
		;;
	esac

  for directory in "$PREFIX/bin" "$DOCDIR/hooks"
  do
    echo "mkdir -p ${directory}"
    mkdir -p ${directory}
    
    echo "chmod 0755 ${directory}"
    chmod 0755 ${directory}
  done

	for exec_file in $EXEC_FILES ; do
    source_file="$REPO_NAME/$exec_file"
    dest_file="$BINDIR/`basename $exec_file`"

    echo "cp ${source_file} ${dest_file}"
    cp ${source_file} ${dest_file}

    echo "chmod 0755 ${dest_file}"
    chmod 0755 ${dest_file}
	done

	for script_file in $SCRIPT_FILES ; do
    source_file="$REPO_NAME/$script_file"
    dest_file="$BINDIR/`basename $script_file`"

    echo "cp ${source_file} ${dest_file}"
    cp ${source_file} ${dest_file}

    echo "chmod 0755 ${dest_file}"
    chmod 0644 ${dest_file}
	done

	for hook_file in $HOOK_FILES ; do
    source_file="$hook_file"
    dest_file="$DOCDIR/hooks/`basename $hook_file`"

    echo "cp ${source_file} ${dest_file}"
    cp ${source_file} ${dest_file}

    echo "chmod 0755 ${dest_file}"
    chmod 0755 ${dest_file}
	done

	exit
	;;
*)
	usage
	exit
	;;
esac
