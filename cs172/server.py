import socket
import socketserver


class SimpleServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


class ReqHandler(socketserver.StreamRequestHandler):
    def handle(self):
        data = self.rfile.readline().strip()
        print(data)
        self.wfile.write("data from server".encode())


if __name__ == '__main__':
    addr = ('127.0.0.1', 10086)
    with SimpleServer(addr, ReqHandler) as server:
        server.serve_forever()
