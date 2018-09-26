#!/bin/bash
#: Title: phoneSearch
#: Date: 2015-9-5
#: Author: "Hitesh Saini" <fxnoob71@gmail.com>
#: Version: 1.0
#: Description :PhoneBook SearchEngine
#: Options: None
exprr=$( echo $1 )
showinfo()
{
  IFS=','
  printf "\n***********************************\n"
  set $info
  printf "SECTION: $d\nRoll_no: $1\nRegistration_no: $2\nName: $3\nWhatsapp_no: $4\nNonWhatsapp: $5"  
  printf "\n***********************************\n"
}

search()
{
dir=$( ls )
for d in $dir
do
   if [ -f "$d" ]
        then
     info=$( grep "$exprr" "$d" -P -i )
        if [ "$info" != "" ]
            then
            showinfo
        fi
 
   fi
done

}
search