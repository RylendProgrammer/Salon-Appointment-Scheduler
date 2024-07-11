#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"



# Start Here:

echo -e "~~~~~ MY SALON ~~~~~\n\n"

echo -e "Welcome to My Salon, how can I help you?\n"

echo -n "1) "
$PSQL "SELECT name FROM services WHERE name = 'Haircut';"
echo -n "2) "
$PSQL "SELECT name FROM services WHERE name = 'Beard';"
echo -n "3) "
$PSQL "SELECT name FROM services WHERE name = 'Eyebrows';"
echo -n "4) "
$PSQL "SELECT name FROM services WHERE name = 'Color';"
echo -n "5) "
$PSQL "SELECT name FROM services WHERE name = 'Nails';"

read SERVICE_ID_SELECTED

while [[ SERVICE_ID_SELECTED -lt 1 || SERVICE_ID_SELECTED -gt 5 ]]; do
  echo -e "\nI could not find that service. What would you like today?"

  echo -n "1) "
 $PSQL "SELECT name FROM services WHERE name = 'Haircut';"
 echo -n "2) "
 $PSQL "SELECT name FROM services WHERE name = 'Beard';"
 echo -n "3) "
 $PSQL "SELECT name FROM services WHERE name = 'Eyebrows';"
 echo -n "4) "
 $PSQL "SELECT name FROM services WHERE name = 'Color';"
 echo -n "5) "
 $PSQL "SELECT name FROM services WHERE name = 'Nails';"

 read SERVICE_ID_SELECTED
done

SERVICE_NAME=""
Haircut='Haircut'
Beard='Beard'
Eyebrows='Eyebrows'
Color='Color'
Nails='Nails'

if [ $SERVICE_ID_SELECTED = 1 ]; then
  SERVICE_NAME='Haircut'
elif [ $SERVICE_ID_SELECTED = 2 ]; then
  SERVICE_NAME='Beard'
elif [ $SERVICE_ID_SELECTED = 3 ]; then
  SERVICE_NAME='Eyebrows'
elif [ $SERVICE_ID_SELECTED = 4 ]; then
  SERVICE_NAME='Color'
elif [ $SERVICE_ID_SELECTED = 5 ]; then
  SERVICE_NAME='Nails'
fi

CUSTOMER_ID=$((1 + RANDOM % 1000))

echo -e "\nWhat's your phone number?"

read CUSTOMER_PHONE

# check if the $phone exists in customers
phone_exists=$(psql --u=freecodecamp --dbname=salon -t -c "SELECT EXISTS (SELECT FROM customers WHERE phone='$CUSTOMER_PHONE');")
phone_exists=$(echo $phone_exists)

if [ $phone_exists = 'f' ]; then
  echo -e "\n\nI don't have a record for that phone number, what's your name?"
  
  read CUSTOMER_NAME

  echo -e "\n\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"

  read SERVICE_TIME

  echo -e "\n\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."

  $PSQL "INSERT INTO customers (customer_id, phone, name) VALUES ($CUSTOMER_ID, '$CUSTOMER_PHONE', '$CUSTOMER_NAME');"
  $PSQL "INSERT INTO appointments (time, customer_id, service_id) VALUES ('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID_SELECTED);"
fi










echo "..."