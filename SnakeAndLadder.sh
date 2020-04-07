#!/bin/bash -x 

declare -A counter
declare -A playerPosition
declare -A score
FINALPOSITION=100

#display start game msg
function start()
{
   echo "------SNAKE AND lADDER GAME START------"
}

#function to generate random number
function rollDice()
{
   UPPER_LIMIT=6
   LOWER_LIMIT=1
   currentPositions=$((RANDOM%($UPPER_LIMIT-$LOWER_LIMIT+1)+$LOWER_LIMIT))
   echo $currentPositions
}

#find feature like snake, ladder & no play
function gameFeature
{
	local play=$1
	playerPosition[$play]=0
	while [[((${playerPosition[$play]} -lt $FINALPOSITION))]]
	do
		currentPosition="$(rollDice)"
		feature=$((RANDOM%3))
		case $feature in
		0)
			echo "No Play you can stays in this" ${playerPosition[$play]} "position"
			;;
		1)
			if [[ (($((${playerPosition[$play]}+$currentPosition)) -le $FINALPOSITION))]]
			then
				playerPosition[$play]=$((${playerPosition[$play]}+$currentPosition))
				score[$play]="${score[$play]}  ${playerPosition[$play]}"
			fi
			echo "Ladder found the player moves ahead on" ${playerPosition[$play]} ", $currentPosition received on the die"
			;;
		2)
			if [[ (($((${playerPosition[$play]}-$currentPosition)) -gt 0 ))]]
			then
				playerPosition[$play]=$((${playerPosition[$play]}-$currentPosition))
				score[$play]="${score[$play]}  ${playerPosition[$play]}"
			else
				playerPosition[$play]=0
			fi
			echo "Snake found the player moves behind on" ${playerPosition[$play]} ", $currentPosition received on the die"
			;;
		esac
	done
	echo "Total no of time dice roll: ${counter[@]}"
	echo "Player position after every dice roll: ${score[@]}"
}

gamePlayer="Player1"
start
gameFeature $gamePlayer
