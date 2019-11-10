import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(('127.0.0.1', 9997))


try:
	while True:
		request = raw_input('>> ');
		if request:
			sock.send(request.encode('utf8'))
		response = sock.recv(1024)
		if response:
			print(response.decode('utf8'))
except KeyboardInterrupt:
	socket.close()
