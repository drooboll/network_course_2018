#!/usr/bin/python3
import socket
import threading
import select

port = 9995
defaultUrl = '127.0.0.1'
mainSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
mainSocket.bind(('0.0.0.0', port))
mainSocket.listen(5)


def clientHandler(clientSocket):

    while True:
        data = clientSocket.recv(1024)
	if len(data) > 0:
		clientSocket.send(b' Returned: ' + data)
		print(data)
	else:
		clientSocket.close()
		break


while True:
    clientSocket, address = mainSocket.accept()
    print('Connection {}:{}'.format(address[0], address[1]))
    clientHandlerFunc = threading.Thread(
        target=clientHandler,
        args=(clientSocket, )
    )
    clientHandlerFunc.start()
