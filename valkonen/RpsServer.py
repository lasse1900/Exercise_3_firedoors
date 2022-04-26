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

    print(request.json)

    for pin in PIN_STATE.keys():
        state = request.json.get(pin)

        if isinstance(state, int): 
            PIN_STATE[pin] = state 

    return "OK"

if __name__ == "__main__":
    app.run()