#helper functions
#getting message after successfully signing up.
SignedUpMessage()
{
  zenity --info title="Now you are Signed Up" --text="Now You can login into the system!!"
}
#info message before program termination.
cmessage()
{
zenity --info title="cancelled" --text="process terminated!!"
}
#hello message after logging in
hello()
{
   dt=$( echo `date +%r` | grep "AM" )
   if [ "$dt" != "" ]
    then
    echo "Good Morning "
    else
    echo "Good Evening "
   fi
}
fetchAtten()
{
  srch=$(  )
}
#communicating to php file through php cli
showAtten()
{
  form=$( zenity --forms --title="Registration  Sys" --width=500 --height=500 --text="SearchBuddy" --add-entry="Registration no" )
  if [ $? -eq 1  ]
      then
      cmessage
  else
      if [ "$form" == "" ]
          then
           zenity --info title="Empty Input" --text="Enter data Again!!!"
           showAtten
      fi    
  fi
}
#logging in after varifying username and password
loginSuccess()
{
   IFS=','
   set $check
   msg=$( hello )
   choice=$( zenity --forms --title="Home Screen" --text="\nHello <b>$2 </b> $msg\n Your Mobile Number: $4\nSignedUp Date: $1\nType 1 for Enqueries dueFee ,2 for SearchBuddy" --width=500 --height=500\
                                                                        --add-entry="q?=" )
    if [ $? -eq 1 ]
        then
        login
        else
        if [ $choice -eq 1 ]
           then
           showAtten
        elif [ $choice -eq 2 ]
          then
            interface=$( zenity --forms --title="Registration  Sys" --width=500 --height=500 --text="SearchBuddy"  --add-entry="q?=" )
  if [ "$interface" != "" ]
             then
             export interface
             cd phonebook
             data=$( bash "phone.sh" $interface )
             file=$( date -I )
             touch $file
             echo $data>$file
             $decision=$( zenity --text-info title="Search Result"  --filename="$file"  --width=500 --height=500 )
             if [ $? -eq 1 ]
                then
               
                rm $file 
                login
                else
                rm $file
                loginSuccess 
             fi   
             else
             zenity --info title="Empty Search" --text="Search Again!!!"
             loginSuccess

        fi     
        fi 
    fi     
}
#registring the new users
register()
{
  infos=$( zenity --forms --title="Registration  Sys" --width=500 --height=500 --text="Enter User & Pass"\
                                                                            --add-entry="Username"\
                                                                            --add-password="Password" \
                                    --add-entry="Mobile"    ) 


  IFS='|'
  set $infos
  d=$( echo `date`,$1,$2,$3 )
  if [ $? -eq 1 ]
    then
    cmessage
  else
   if [ 0 -eq 0 ] 
      then
      echo $d>>credentials.txt 
      else
      zenity --info title="Empty Input" --text="Empty Input!!"
      register
   fi                 
  CHECK=$( zenity --question --text="proceed ahead?" --title="checkpoint" )
  if [ $? -eq 1 ]
     then
     cmessage
  else
     #signing in completion message
     SignedUpMessage
     #redirecting to login screen
     login
  fi 
  fi
}
#login for the registered users only
login()
{

info=$( zenity --forms --title="LOGIN Sys" --width=500 --height=500 --text="Enter User & Pass"\
                                                                            --add-entry="Username"\
                                                                            --add-password="Password" )

if [ $? -ne 1 ]
 then
IFS='|'
set $info
un=$1
pass=$2
check=$( awk -F "," -f "loginCheck.awk" -v un=$un pass=$pass credentials.txt )
if [ "$check" == "" ]
   then
     reg=$( zenity --question --text="you are not registerd yet!!\nWould u like to register first?"  --title="Seletion Panel" )
     if [ $? -eq 1 ]
       then
       cmessage
      else
       register
     fi 
else
  loginSuccess
fi
else
  cmessage
fi

}

login