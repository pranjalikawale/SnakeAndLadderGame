#!/bin/bash

gameOn=1
finalPosition=100
declare -A counter
declare -A score
declare -A player
player=0
function start()
{
   #player[]=0
   #score[]=0
   #counter[]=0
   echo "------SNAKE AND lADDER GAME START------"
   gamePlay
}

function rollDice()
{
   UPPER_LIMIT=6
   LOWER_LIMIT=1
   currentPositions=$((RANDOM%($UPPER_LIMIT-$LOWER_LIMIT+1)+$LOWER_LIMIT))
   echo $currentPositions
}

function gameFeature
{
      local play=$1
      currentPosition="$(rollDice)"
      ((counter[$play]++))
      feature=$((RANDOM%3))
      case $feature in
      0)
         echo "No Play you can stays in this" ${player[$play]} "position"
         ;;
      1)
         if [[ (($((${player[$play]}+$currentPosition)) -le 100)) ]]
         then
            player[$play]=$((${player[$play]}+$currentPosition))
         fi
         score[$play]="${score[$play]}  ${player[$play]}"
         echo "Ladder found the player moves ahead on" ${player[$play]} ", $currentPosition received in the die"
         ;;
      2)
         if [[ (($((${player[$play]}-$currentPosition)) -gt 0 ))]]
         then
            player[$play]=$((${player[$play]}-$currentPosition))
         else
            player[$play]=0
         fi
         score[$play]="${score[$play]}  ${player[$play]}"
         echo "Snake found the player moves behind on" ${player[$play]} ", $currentPosition position received in the die"
         ;;
      esac
      checkWinningCondition $play
}

function gamePlay()
{
   while [[(($gameOn -gt 0))]]
   do
      if [[(( $((RANDOM%2)) -eq 0))]]
      then
         echo "Player1 is turns"
         gamePlayer="Player1"
         gameFeature $gamePlayer
      else
         echo "Player2 is turns"
         gamePlayer="Player2"
         gameFeature $gamePlayer
      fi
   done
   echo "Players: ${!counter[@]}"
   echo "Total no of time dice roll: ${counter[@]}"
   echo "Players: ${!score[@]}"
   echo "Player position after every dice roll: ${score[@]}"
}

function checkWinningCondition()
{
   local play=$1
   if [[((${player[$play]} -eq $finalPosition)) ]]
   then
      echo "$1 is winner"
      gameOn=0
   fi
}
start
