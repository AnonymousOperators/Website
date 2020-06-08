
# /home/app/app.py


from flask import Flask, render_template

#Extentions 
from flask_pymongo import PyMongo




app = Flask(__name__)
app.config["MONGO_URI"] = "mongodb://localhost:27017/myDatabase"
mongo = PyMongo(app)

'''
Starting with MongoDB 2.6 user management is handled with four commands
 createUser_, usersInfo_, updateUser_, and dropUser_.
'''


@app.route("/")
def index():
    return render_template("index.html.j2")

@app.route("/about")
def about():
    return render_template("about.html.j2")

if __name__ == "__main__":
    app.run(host='0.0.0.0')

