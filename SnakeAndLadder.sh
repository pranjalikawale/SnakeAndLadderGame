#!/bin/bash -x

gameOn=1
FINALPOSITION=100
declare -A counter
declare -A score
declare -A playerPosition=0

#start the game to play
function gamePlay()
{
	echo "------SNAKE AND lADDER GAME START------"
	isPlay=1
	while [[(($gameOn -gt 0))]]
	do
		if [[(( $((isPlay%2)) -eq 0))]]
		then
			gamePlayer="Player1"
			gameFeature $gamePlayer
		else
			gamePlayer="Player2"
			gameFeature $gamePlayer
		fi
		((isPlay++))
	done 
	displayCount
	displayScore
}

#roll a dice
function rollDice()
{
	UPPER_LIMIT=6
	LOWER_LIMIT=1
	currentPositions=$((RANDOM%($UPPER_LIMIT-$LOWER_LIMIT+1)+$LOWER_LIMIT))
	echo $currentPositions
}

#include feature to get snake ladder and no play
function gameFeature()
{
	local play=$1
	echo "$play 's turns"
	
	case $((RANDOM%3)) in
	0)
		echo "No Play you can stays in this" ${playerPosition[$play]} "position"
		;;
	1)
		foundLadder $play
		;;
	2)
		foundSnake $play
		;;
	esac
	((counter[$play]++))
	checkWinningCondition $play
}

#snake found decrement position
function foundSnake()
{
	local playing=$1
	local dice="$(rollDice)"
	
	if [[ (($((${playerPosition[$playing]}-$dice)) -gt 0 ))]]
	then
		playerPosition[$playing]=$((${playerPosition[$playing]}-$dice))
		score[$playing]="${score[$playing]}  ${playerPosition[$playing]}"
	else
		playerPosition[$playing]=0
	fi
	echo "$dice received in the die"
	echo "Snake found the $playing moves behind on ${playerPosition[$playing]}"
}

#ladder found increment position
function foundLadder()
{
	local playing=$1
	local dice="$(rollDice)"
	
	if [[ (($((${playerPosition[$playing]}+$dice)) -le $FINALPOSITION ))]]
	then
		playerPosition[$playing]=$((${playerPosition[$playing]}+$dice))
		score[$playing]="${score[$playing]}  ${playerPosition[$playing]}"
	fi
	echo "$dice received in the die"
	echo "Ladder found the $playing moves ahead on ${playerPosition[$playing]}"
}

#check condition of player win
function checkWinningCondition()
{
	local winner=$1
	
	if [[((${playerPosition[$play]} -eq $FINALPOSITION)) ]]
	then
		echo "*******Congratulation $winner is winner*******"
		gameOn=0
	fi
}

#display number of time dice roll
function displayCount()
{
	for count in "${!counter[@]}"
	do
		echo $count "roll disc ${counter[$count]}"
	done
}

#display score every score after dice roll
function displayScore()
{
	for position in "${!score[@]}"
	do
		echo $position "Scores on disc after every dice roll: ${score[$position]}"
	done
	echo "Total no of time dice roll: ${counter[@]}"
	echo "Player position after every dice roll: ${score[@]}"
}

gamePlay
