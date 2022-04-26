from flask import Flask, request, abort, jsonify

USERS = { "admin": "12345678" }
PIN_STATE = { "P1": 0, "P2": 0, "P3": 0, "P4": 0, }

app = Flask(__name__)

def check_passwd(req):
    username = req.json.get("username", "")
    password = req.json.get("password", "")
    real_password = USERS.get(username)

    if username not in USERS or password != real_password:
        abort(403)

@app.route("/PinState", methods=["GET", "POST"])
def pin_state():
    check_passwd(request)

    if request.method == "GET":
        return jsonify(PIN_STATE)

    p1 = request.json.get("P1")
    p2 = request.json.get("P2")
    p3 = request.json.get("P3")
    p4 = request.json.get("P4")
    if p1: PIN_STATE["P1"] = p1 
    if p2: PIN_STATE["P2"] = p2 
    if p3: PIN_STATE["P3"] = p3 
    if p4: PIN_STATE["P4"] = p4 
    return "OK"

if __name__ == "__main__":
    app.run()