import socket
import sys

HOST, PORT = "localhost", 10086
data = "Hello from client"

# Create a socket (SOCK_STREAM means a TCP socket)
sock = socket.socket()

# Connect to server and send data
sock.connect((HOST, PORT))
sock.sendall(bytes(data + "\n", "utf-8"))

# Receive data from the server and shut down
received = str(sock.recv(1024), "utf-8")

print("Sent:     {}".format(data))
print("Received: {}".format(received))