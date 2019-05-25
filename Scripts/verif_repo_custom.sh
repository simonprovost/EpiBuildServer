#!/usr/bin/env bash

################################## MAIN
description="   This script, clone the repo and test some commands to check if the repo is good to be delivered to Epitech"

login=$1
nameProject=$2
binary_name=$3
branch_name=$4
rule_name=$5

################################## GLOBAL VARIABLE
#nameProject=NULL
folder_name=${nameProject}
link_clone=git@git.epitech.eu:/${login}@epitech.eu/${nameProject}
#binary_name=NULL

################################## FUNCS
function exitError() {
    local code="\033["
    colorgreen="${code}1;31m"

    echo "_____________________________________"
	echo -ne "$colorgreen Error : $1.${code}0m\n\n"
	exit 1
}

function success() {
local code="\033["
colorgreen="${code}1;32m"

    echo "_____________________________________"
	echo -ne "$colorgreen success : $1.${code}0m\n"
}

function binary() {
    ls ./$1 &> /dev/null
    if [[ $? == 0 ]]; then
	exitError 'Before pushing, you must delete your binary with make fclean.'
	fi
}

function delay()
{
    sleep 0.2;
}

CURRENT_PROGRESS=0
function progress()
{
    PARAM_PROGRESS=$1;
    PARAM_PHASE=$2;
    local code="\033["
    colorgreen="${code}1;32m"
    colorpurple="${code}1;35m"
    colorred="${code}1;31m"

    echo -ne "$colorgreen ${code}0m $colorred (${PARAM_PROGRESS}%)  ${code}0m $colorpurple $PARAM_PHASE ${code}0m\r\n"
    CURRENT_PROGRESS=$PARAM_PROGRESS;
}

################################## MAIN

if [[ -d "temp_verif" ]]; then
      rm -rf temp_verif
fi
mkdir temp_verif
cd temp_verif

progress 33 "Clone..."
     if [[ -d "$folder_name" ]]; then
          rm -rf ${folder_name}
     fi
     git clone -b ${branch_name} --single-branch ${link_clone} &> /dev/null
     if [[ $? -ne 0 ]]; then
        git clone -b ${branch_name} --single-branch ${link_clone}
        exitError 'Clone Failed'
     fi
progress 66 "Clone success."
    cd ${folder_name}/
    binary ${binary_name}
progress 100 "{$binary_name} Binary : OK."
    make ${rule_name} &> /dev/null
	if [[ $? -ne 0 ]]; then
	    make
		exitError "make failed, make sure that {$rule_name} rule exists"
	fi