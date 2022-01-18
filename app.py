#!/usr/bin/env python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def welcome():
    return 'Hello World AGAIN !\n'

@app.route('/hello_world/')
def hello_world():
    return 'Very Hello World !\n'

@app.route('/<username>') # dynamic route
def hello_user(username):
    return 'Welcome back, %s!\n' % username

if __name__ == '__main__':
    app.run()#host='0.0.0.0')     # open for everyone