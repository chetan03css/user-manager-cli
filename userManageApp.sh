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
 #      echo "UID : $uid"
        nuid=$uid
  else
 #    uid=$(sort -r ~/users.dat | cut -d ':' -f 1 | head -1)
     uid=$(cat ~/users.dat | tail -1 | cut -d ':' -f 1)
 #   echo "Latest UID :$uid"
     nuid=$[$uid+1]
     echo "UID : $nuid"
  fi


  echo "$nuid:$pwd:$fname:$lname:$zipcode" >> ~/users.dat
  echo "User Added Successfully"
  echo
  echo
}



search_user()
{
  read -p "Enter User ID:" uid
  read -p "Enter Password:" pwd
  count=$(grep $uid ~/users.dat | wc -l)
  if [ $count -eq 0 ]; then
  	echo "User ID: $uid does not exist"
	return 3
  fi
  count=$(grep $uid ~/users.dat | grep $pwd | wc -l)
  if [ $count -eq 0 ]; then
  	echo "Invalid Password"
 	return 4
  fi
  echo "The complete information of the user:"
  record=$(grep $uid ~/users.dat)
  echo "User ID : $(echo $record | cut -d ':' -f 1)"
  echo "Password: $(echo $record | cut -d ':' -f 2)"
  echo "First Name: $(echo $record | cut -d ':' -f 3)"
  echo "Last Name: $(echo $record | cut -d ':' -f 4)"
  echo "Zip Code : $(echo $record | cut -d ':' -f 5)"
  echo
  echo

}

change_password()
{
  read -p "Enter User ID:" uid
  read -p "Enter Password:" pwd
  count=$(grep $uid ~/users.dat | wc -l)
  if [ $count -eq 0 ]; then
        echo "User ID: $uid does not exist"
        return 3
  fi
  count=$(grep $uid ~/users.dat | grep $pwd | wc -l)
  if [ $count -eq 0 ]; then
        echo "Invalid Password"
        return 4
  fi
  record=$(grep $uid ~/users.dat)
  grep -v $uid ~/users.dat > temp.dat
  rm ~/users.dat
  mv temp.dat ~/users.dat
 
  read -p "Enter New Password:" npwd
  uid=$(echo $record | cut -d ':' -f 1)
  fname=$(echo $record | cut -d ':' -f 3)
  lname=$(echo $record | cut -d ':' -f 4)
  zipcode=$(echo $record | cut -d ':' -f 5)
  echo "$uid:$npwd:$fname:$lname:$zipcode" >> ~/users.dat
  echo "Password updated successfully"
  echo
  echo
}

delete_user()
{
  read -p "Enter User ID:" uid
  read -p "Enter Password:" pwd
  count=$(grep $uid ~/users.dat | wc -l)
  if [ $count -eq 0 ]; then
        echo "User ID: $uid does not exist"
        return 3
  fi
  count=$(grep $uid ~/users.dat | grep $pwd | wc -l)
  if [ $count -eq 0 ]; then
        echo "Invalid Password"
        return 4
  fi
  grep -v $uid ~/users.dat > temp.dat
  rm ~/users.dat
  mv temp.dat ~/users.dat  
  echo "User Deleted Successfully"
  echo
  echo
}

show_all_users()
{
  echo "All Users Information:"
  echo "======================"
  cat < ~/users.dat
  echo
  echo
}

user_count()
{
  count=$(cat ~/users.dat | wc -l)
  echo "The Total Number of Users: $count"
  echo
  echo
}


echo "Welcome to User Management App"
echo "=============================="

while [ true ]
do
	echo "1. Add User"
	echo "2. Search User"
	echo "3. Change Password"
	echo "4. Delete User"
	echo "5. Show All User"
	echo "6. User Count"
	echo "7. Exit User"
	read -p "Enter your choice [1/2/3/4/5/6/7] : " choice
	
	case $choice in
	     1) 
		add_user
		;;
	     2) 
		search_user
		;;

	     3) 
		change_password
		;;
	
	     4) 
		delete_user
		;;
	     5) 
		show_all_users
		;;
	     6) 
		user_count
		;;
	     7) 
		echo "Thanks for using the application"
		exit 0
		;;
	     *) 
		echo "Wrong Choice.. Try Again"
	esac
done

