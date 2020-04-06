#!/bin/bash 

declare -A playerPosition
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

start
rollDice
