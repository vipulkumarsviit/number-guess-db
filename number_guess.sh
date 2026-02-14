#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
SECRET_NUMBER=$(( $RANDOM % 1000 + 1 ))

echo "Enter your username:"
read USERNAME

# USER_ID=$($PSQL "select user_id from users where username = '$USERNAME'")

if [[ -z $USER_ID ]]; then
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
  INSERT_USER=$($PSQL "insert into users (username) values ('$USERNAME')")
  USER_ID=$($PSQL "select user_id from users where username = '$USERNAME'")
else
  GAMES_PLAYED=$($PSQL "select count(*) from games where user_id = $USER_ID")
  BEST_GAME=$($PSQL "select min(number_of_tries) from games where user_id = $USER_ID and winner = true")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games?, and your best game took $BEST_GAME guess(es)?."
fi

# INSERT_GAME=$($PSQL "insert into games (user_id, secret_number) values ($USER_ID, $SECRET_NUMBER)")

# GAME_ID=$($PSQL "select game_id from games where user_id = $USER_ID order by game_id desc limit 1")

# echo -e "\nGuess the secret number between 1 and 1000:"

# NUMBER_OF_GUESSES=0

# MAIN_MENU(){
#   ((NUMBER_OF_GUESSES++))
#   read USER_GUESS
#   if [[ "$USER_GUESS" =~ ^-?[0-9]+$ ]]; then
#     if [[ $SECRET_NUMBER -eq $USER_GUESS ]]; then
#       echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
#       UPDATE_GAME=$($PSQL "update games set number_of_tries = $NUMBER_OF_GUESSES where game_id = $GAME_ID")
#       UPDATE_GAME=$($PSQL "update games set winner = true where game_id = $GAME_ID")
#     elif [[ $SECRET_NUMBER -lt $USER_GUESS ]]; then
#       echo -e "\nIt's lower than that, guess again:"
#       UPDATE_GAME=$($PSQL "update games set number_of_tries = $NUMBER_OF_GUESSES where game_id = $GAME_ID")
#       MAIN_MENU
#     else
#       echo -e "\nIt's greater than that, guess again:"
#       UPDATE_GAME=$($PSQL "update games set number_of_tries = $NUMBER_OF_GUESSES where game_id = $GAME_ID")
#       MAIN_MENU
#     fi
#   else
#     echo -e "That is not an integer, guess again:"
#     UPDATE_GAME=$($PSQL "update games set number_of_tries = $NUMBER_OF_GUESSES where game_id = $GAME_ID")
#     MAIN_MENU
#   fi
# }

# MAIN_MENU

