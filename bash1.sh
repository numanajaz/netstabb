#!bin/bash/

echo "1"
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

#getting ip address
echo "1. Network Info" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo "___________________________________________________________________________________" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

ip=$(echo '0000' | sudo -S curl ifconfig.me)
echo "Network IP is: $ip">> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

ip=$(echo '0000' | sudo -S ip route show 0.0.0.0/0 | grep -oP 'via \K\S+')

echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo "Default gateway: " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo '0000' | sudo -S ip route show 0.0.0.0/0 | grep -oP 'via \K\S+'>> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo "Inet: " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo '0000' | sudo -S ip route get $(ip route show 0.0.0.0/0 | grep -oP 'via \K\S+') | grep -oP 'src \K\S+'>> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo "List of Live Devices: " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo '0000' | sudo -S arp-scan -r 3 -b 2 --localnet>> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

#Locating Firewall
echo "2. Locating Firewall" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo "___________________________________________________________________________________" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

locate=$(echo '0000' | sudo -S nmap -sX $ip| grep -w 'PORT\|open\|closed\|filtered\|MAC')
clear
echo "$locate" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
clear
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo '0000' | sudo -S clear 

if echo "$locate" | grep -w 'closed\|filtered';
then
  echo "Test Verdict :		Firewall Detected" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
else
	echo "Firewall Not Detected" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
fi

echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

#Discovery Scan
echo "3. Discovery Scan" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo "___________________________________________________________________________________" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo '0000' | sudo -S fping $ip -c8 >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo "Test Verdict :		Host Live" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

#Banner Grabbing
echo "4. Banner Grabbing" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo "___________________________________________________________________________________" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo "Service Info: " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo '0000' | sudo -S nmap -sV --script=banner $ip >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

#Port Scanning
echo "5. Port Scanning" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo "___________________________________________________________________________________" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo "TCP port scan vulnerability report: " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo '0000' | sudo -S nmap -sT $ip | grep -w 'PORT\|open\|closed\|filtered\|MAC' >>  /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo "FIN port scan vulnerability report: " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo '0000' | sudo -S nmap -sF $ip | grep -w 'PORT\|open\|closed\|filtered\|MAC'>> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo "NULL port scan vulnerability report: " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo '0000' | sudo -S nmap -Pn -sN -sV -p1-65535 --script=firewall-bypass $ip | grep -w 'PORT\|VERSION\|Service Info\|open\|closed\|filtered\|MAC'>>  /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo "XMAS port scan vulnerability report: " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo '0000' | sudo -S nmap -sX $ip | grep -w 'PORT\|open\|closed\|filtered\|MAC'>>  /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

# IP Spoofing
echo "6. IP Spoofing" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo "___________________________________________________________________________________" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo '0000' | sudo -S hping3 -a "192.168.1.8" -S $ip -c 2 -p 80 >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo "Receiving Custom Spoofed IP Packets." >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

# Custom Packet tests
echo "7. Custom Packets tests" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo "___________________________________________________________________________________" >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo "Sending Random Source Packets: " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo '0000' | sudo -S hping3 --rand-source -S $ip -c 10 >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo "Sending Packets Flaged as Urgent: " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo '0000' | sudo -S hping3 -U -S -s 5555 -c 1 $ip >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo "Sending Push Flag Enabled Packets: " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo '0000' | sudo -S hping3 -P -S -s 5555 -c 1 $ip >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt
echo " " >> /home/blackjack/NetBeansProjects/netstabgui/src/main/java/report.odt

clear


