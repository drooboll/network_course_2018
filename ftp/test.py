import socket, threading

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(('127.0.0.1', 1026))

def to_socket(sock):
	while True:
		request = input('>> ');
		sock.send((request + '\r\n').encode('utf8'))
def from_socket(sock):
	while True:
		print(sock.recv(1024).decode('utf8'))

to = threading.Thread(target=to_socket, args=(sock,))
fr = threading.Thread(target=from_socket, args=(sock,))
to.start()
fr.start()
