#!/bin/bash -x
#constant
START_POSITION=0
FINAL_POSITION=100
NO_PLAY=0
SNAKE=1
LADDER=2

#variable
dice=0
option=0
position=$START_POSITION
numberOfTimesDiceRolled=0
player1=0
player2=0
count=0
turn=0

declare -a array

#function for rolling a die
rollDie() {
	dice=$(( RANDOM % 6 + 1 ))
	option=$(( RANDOM % 3 + 1 ))
	numberOfTimesDiceRolled=$(( $numberOfTimesDiceRolled + 1 ))
}

#function for checking options
checkOption() {
	rollDie
	case $option in
		1)
			position=$(($position-$dice))
			;;
		2)
			position=$(($position+$dice))
			;;
		3)
			position=$position
			;;
		esac
}

#function for winning condition till exact 100 position
winningPosition() {
		checkOption
		if [ $position -lt $START_POSITION ]
		then
			position=$START_POSITION
		elif [ $position -gt $FINAL_POSITION ]
		then
			position=$(($position - $dice))
		fi
		array[$count]=$position
		count=$(($count + 1))
}

#function for current position
currentPosition() {
	position=$1
	winningPosition
}

#function for checking win
checkWin() {
	while [ $position -ne $FINAL_POSITION ] || [ $position -gt $FINAL_POSITION ]
	do
		if [ $turn -eq 0 ]
		then
			turn=1
			currentPosition $player1
			player1=$position
		else
			turn=0
			currentPosition $player2
			player2=$position
		fi
	done
	turn=0
}

#function for printing position after every die
positionAfterEveryDie() {
	checkWin
	for (( boardPosition=0 ; boardPosition<$numberOfTimesDiceRolled ; boardPosition++ ))
	do
		if [ $turn -eq 0 ]
		then
			turn=1
			echo "Turn of Dice $(($boardPosition +1)) : Player1 : Position ${array[$boardPosition]}"
		else
			turn=0
			echo "Turn of Dice $(($boardPosition +1)) : Player2 : Position ${array[$boardPosition]}"
		fi
	done
}

positionAfterEveryDie

#check who wins
if [ $player1 -gt $player2 ]
then
	echo "Player1 wins..."
else
	echo "Player2 wins..."
fi
echo "Total number of times dice Rolled: $boardPosition"
