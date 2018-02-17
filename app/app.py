from flask import Flask, render_template
from redis import Redis, RedisError
import os
import socket

# Connect to Redis
redis = Redis(host="redis", db=0, socket_connect_timeout=2, socket_timeout=2)

app = Flask(__name__)


@app.route('/')
def showMachineList():
    return render_template('list.html')


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
