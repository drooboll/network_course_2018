import pcapy
import os
from scapy.all import *
os.system("tshark -T fields -e frame.time -e data.data -w eaves.pcap > eaves.txt -F pcap -c 180 -J 'http tcp' -f 'tcp port 80'")
data = "eaves.pcap"
fil = rdpcap(data)
sessions = fil.sessions()
for session in sessions:
	for packet in sessions[session]:
		image_detected = 0
		image_parts = b''
		if packet[TCP].sport == 80:
			##print(packet[TCP].payload)
			string = packet[TCP].payload
			print(string.find(b'image/jpeg'))
			if b'image/jpeg' in packet[TCP].payload:
				image_detected = 1
			if image_detected:
				image_parts += packet[TCP].payload
	##if image_parts:
	##	print(image_parts)
