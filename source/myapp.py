
from flask import Flask
server = Flask(__name__)

@server.route("/")
def greeting():
     return "Hi there, Siphiwe here. Updating the code"

if __name__ == "__main__":
    server.run(host='0.0.0.0')


