#!/bin/bash
#
#
# this script:
# creates 2 users, and adds their ssh key
# restricts ssh access
# sets motd and ssh banner
# determines if iptables is required
# sets iptables

user1=user1
user2=user2

if [ -d "/home/$user1" ] && [ -d "/home/$user2" ] && [ -d "/home/$user3" ]; then
echo "...one of these these numbnuts already exists '$user1,$user2,$user3'"

else

echo

echo "...useradd user1, user2"

useradd -c "User 1" -d /home/$user1 -e "" -m -s /bin/bash -u 164109 user1
useradd -c "User 2" -d /home/$user2 -e "" -m -s /bin/bash -u 164113 user2

mkdir -p /home/$user1/.ssh /home/$user2/.ssh

echo "ADD KEY HERE" > /home/$user1/.ssh/authorized_keys

echo "ADD KEY HERE" > /home/$user2/.ssh/authorized_keys

for dir in /home/$user1; do
username=$(basename $dir)
echo "changing ownership to $username in $dir"
chown -R $username.$username $dir
chmod g-w /home/$user1/.ssh/authorized_keys
chmod og-wrx /home/$user1/.ssh
chmod og-wrx /home/$user1
done

for dir in /home/$user2; do
username=$(basename $dir)
echo "changing ownership to $username in $dir"
chown -R $username.$username $dir
chmod g-w /home/$user2/.ssh/authorized_keys
chmod og-wrx /home/$user2/.ssh
chmod og-wrx /home/$user2
done

fi

##SSH config

IP=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 |  awk '{print $1}')

echo

echo "...restricting ssh listening address to = $IP"

echo

#echo "...disable root logon and password authentication"

sed -i "s/#ListenAddress 0.0.0.0/ListenAddress $IP/g
        s/#PermitRootLogin yes/PermitRootLogin no/g
        s/#PasswordAuthentication yes/PasswordAuthentication no/g
        /#Banner/ a\ Banner /etc/ssh/ssh_banner" /etc/ssh/sshd_config

echo

echo "...setting ssh banner"

echo "  ======================================================================
        |                                                                    |
        |                  * * *    W A R N I N G   * * *                    |
        |                                                                    |
        |                   This server is the property                      |
        |                             CITY 17                                |
        |                                                                    |
        |                  * * *    W A R N I N G   * * *                    |
        |                                                                    |
        | If you are not authorized to access this system, disconnect now.   |
        |                                                                    |
        | Users of this system have no expectation of privacy.               |
        | By continuing, you consent to your keystrokes and data content     |
        | being monitored.                                                   |
        ======================================================================  " > /etc/ssh/ssh_banner


### motd config

HOST=$HOSTNAME
DATE=$(date)
MEM=$(cat /proc/meminfo)

if [ -f /etc/debian_version ]; then
    OS=Debian
    VER=$(cat /etc/debian_version)

echo

echo "...setting motd "

echo   "
          ________________________________________________

          Welcome to $HOSTNAME
          Build Date: $DATE
          You are running on $OS $VER
          Administrators User1, User2
          ________________________________________________

                                                                " > /etc/motd

elif [ -f /etc/redhat-release ]; then
    OS=RedHat
    VER=$(cat /etc/redhat-release)

echo

echo "...setting motd"

echo   "
          ________________________________________________

          Welcome to $HOSTNAME
          Build Date: $DATE
          You are running on $OS $VER
          Administrators User 1, User 2
          ________________________________________________

                                                                " > /etc/motd
fi


###iptables config

IP=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 |  awk '{print $1}')

if [[ $IP == "INSERT IP RANGE"* ]] || [[ $IP == "INSERT IP RANGE"* ]]

then

echo

echo "...iptables not needed as $HOSTNAME has an ip of $IP and is therefore behind the firewall...exiting"; exit


else

echo

echo "...creating iptables for $HOSTNAME $IP"

iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

echo

echo "...allow ssh from corp"

iptables -A INPUT -p tcp -s "INSERT IP" --dport 22 -j ACCEPT

echo

echo "...allow icmp from corp"

iptables -A INPUT -p icmp --icmp-type 8 -s "INSERT IP" -d 0/0 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

echo

echo "...open port 80"

iptables -A INPUT -p tcp --dport 80 -j ACCEPT

echo

echo "...open port 443"

iptables -A INPUT -p tcp --dport 443 -j ACCEPT

echo

echo "...drop all traffic"

iptables -A INPUT -j DROP

fi

if [ -f /etc/debian_version ]; then

echo
        echo "...saving and adding to startup script for Debian based systems"
iptables-save > /etc/iptables.rules

echo "I don't always have a cold one but when I do it's after I run this."

echo "#!/bin/sh
iptables-restore < /etc/iptables.rules
exit 0" > /etc/network/if-pre-up.d/iptablesload

chmod u+x /etc/network/if-pre-up.d/iptablesload

elif [ -f /etc/redhat-release]; then

echo

echo "...saving for rhel systems"

/etc/init.d/iptables save

echo "Stay thirsty my friends!!!!!!"

fi
                                            
