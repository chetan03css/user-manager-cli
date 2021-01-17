add_user()
{
  echo "Provide Details to add user:"
  read -p "First Name:" fname
  read -p "Last Name:" lname
  #read -p "User ID:" uid
  read -s -p "Password:" pwd
  echo
  read -p "Retype Password:" cpwd
  if [ $pwd != $cpwd ]; then
        echo "Password not matching"
        return 1
  fi
  read -p "Zip Code:" zipcode
  if [ ! -e ~/users.dat ];then
        touch ~/users.dat
  fi
  #echo "counting..:"
  count=$(sort ~/users.dat | wc -l)
  #echo $count
  if [ $count -eq 0 ]
  then
        uid=$[100]
 #	echo "UID : $uid"
  	nuid=$uid
  else
     uid=$(sort -r ~/users.dat | cut -d ':' -f 1 | head -1)
 #   echo "Latest UID :$uid"
     nuid=$[$uid+1]
     echo "UID : $nuid"
  fi


  echo "$nuid:$pwd:$fname:$lname:$zipcode" >> ~/users.dat
  echo "User Added Successfully"
  echo
  echo
}

add_user
