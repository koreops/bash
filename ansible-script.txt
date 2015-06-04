#create ansible user and home dir
useradd -c "ansible" -d /home/ansible -e "" -m -s /bin/bash -u 164129 ansible
#make ssh dir
mkdir /home/ansible/.ssh
#copy pub key to authorized_keys
echo "INSERT PUB KEY HERE" >> /home/ansible/.ssh/authorized_keys
#change ownership
chown -R ansible:ansible /home/ansible/.ssh
#add to sudoers if needed
echo 'ansible ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
