#!/bin/bash 

declare -A playerPosition
declare -A score
playerPosition=0

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
	currentPosition="$(rollDice)"
	feature=$((RANDOM%3))
   case $feature in
   0)
		echo "No Play you can stays in this" ${playerPosition[$play]} "position"
     	;;
   1)
		playerPosition[$play]=$((${playerPosition[$play]}+$currentPosition))
		score[$play]="${score[$play]}  ${playerPosition[$play]}"
		echo "Ladder found the player moves ahead on" ${playerPosition[$play]} ", $currentPosition received on the die"
      ;;
   2)
		playerPosition[$play]=$((${playerPosition[$play]}-$currentPosition))
      score[$play]="${score[$play]}  ${playerPosition[$play]}"
      echo "Snake found the player moves behind on" ${playerPosition[$play]} ", $currentPosition received on the die"
      ;;
      esac
}

gamePlayer="Player1"
start
gameFeature $gamePlayer
