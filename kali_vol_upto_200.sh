#BASH CODES HERE
#Voice Controller
#Dev :[H$]
volume=0
while [ true ]
do
 volume=$( zenity --scale --value=$volume --text="Volume Controller Utility.Set Volume" )
 voiceAmplify=$( echo "$volume+100" | bc )
 echo $voiceAmplify
 if [ $? -ne 1 ]
  then 
   pactl -- set-sink-volume  0 "$voiceAmplify%"     
   echo "volume set to $voiceAmplify"
   ifproceed=$( zenity --question --text="Want to change volume Again?" )  
   if [ $? -ne 1 ]
    then
        continue 
   else 
        break   
   fi
 else
  break  
 fi
done