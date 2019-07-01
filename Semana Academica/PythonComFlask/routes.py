from . import app
from flask import render_template


@app.route("/hello")
def hello():
    return "Hellooooo boys"


@app.route("/home/<string:a>")
def home(a):
    return render_template('index.html', nome = a)


@app.route("/calc/<float:a>/<float:b>/<string:c>")
def calc(a, b, c):
    if c == '+':
        return str(a+b)

    if c == '-':
        return str(a-b)

    if c == '*':
        return str(a*b)

    if c == ':':
        return str(a/b)

    if c == '^':
        return str(a**b)
