# /home/app/app.py

from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html.j2")

@app.route("/about")
def about():
    return render_template("about.html.j2")

@app.route("/manifesto")
def manifest():
    return render_template("manifesto.html.j2")

@app.route("/hacking")
def hacking():
    return render_template("hacking.html.j2")

@app.route("/rules")
def rules():
    return render_template("rules.html.j2")

@app.route("/ops")
def ops():
    return render_template("ops.html.j2")

@app.route("/learn")
def learn():
    return render_template("learn.html.j2")


if __name__ == "__main__":
    app.run(host='0.0.0.0')

