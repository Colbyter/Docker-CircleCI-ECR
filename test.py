import os
from flask import Flask, request

app = Flask(__name__)

APP_IP = os.environ.get("APP_IP")
APP_PORT = os.environ.get("APP_PORT")


@app.route("/liveness", methods=['GET'])

def liveness():
    '''Checks app's liveness'''
    return 'OK'


@app.route('/', methods=['GET'])

def zendesk_payload():
    return 'Hello World! New build 4'


if __name__ == '__main__':
    #app.run(host='0.0.0.0', port=10061, debug=True)
    app.run(host=str(APP_IP), port=int(APP_PORT), debug=False)
