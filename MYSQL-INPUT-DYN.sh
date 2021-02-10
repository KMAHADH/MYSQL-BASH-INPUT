#!/bin/bash



echo "Input USERNAME..."
read USERNAME
echo  ""

echo "Input PASSWORD..."
read PASSWORD
echo  ""

echo "Input DATABASE..."
read DATABASE
echo  ""

echo "Input TABLE..."
read TABLE
echo  ""

FIELDSRAW=$(mysql $DATABASE -u $USERNAME -p$PASSWORD -se "DESCRIBE $TABLE")

FIELDS1=$(echo "$FIELDSRAW" | cut -f1)

FIELDS2=$(echo "$FIELDS1" | sed "1d")

arr=($(echo "$FIELDS2"))

NUMB=`echo ${#arr[@]}`

for i in "${arr[@]}"
do
echo "Input "$i"..."
read $i
echo  ""
done

mysql --user=$USERNAME --password=$PASSWORD $DATABASE << EOF

INSERT INTO $TABLE (`echo "@FIELDS2"`) VALUES (`echo "$FIELDS"`);

EOF
