from flask import Flask, request
from flask_httpauth import HTTPBasicAuth


app = Flask(__name__)
auth = HTTPBasicAuth()

users = {
        'admin': '12345678',
        'lasse': '12345678'
}
app.url_map.strict_slashes = False

PINS = ['sf1', 'sf2', 'sf3', 'sf4']

PINS_STATUS = {'sf1':'0', 'sf2': '0', 'sf3':'0', 'sf4':'0'}

@auth.get_password
def get_pw(username):
        if username in users:
                return users.get(username)
        return None

@app.route('/')
@auth.login_required
def index():
        return "Hello, %s!" % auth.username()

def get_html_string():
        html_str = '<html>sf1={}sf2={}sf3={}sf4={}</html>'.format(PINS_STATUS['sf1'],
                                                PINS_STATUS['sf2'],
                                                PINS_STATUS['sf3'],
                                                PINS_STATUS['sf4'])
        
        return html_str

def parse_cmd_args(args):
        global current_status
        if str(args['CMD']) == 'SetPower':
                for key in args:
                        if key in PINS:
                                PINS_STATUS[key] = str(args[key])
                                
                return get_html_string()
        
        if str(args['CMD']) == 'GetPower':
               return get_html_string()
       

@app.route('/SetCmd', methods=['GET','POST'])
def rps():
        if request.method=="GET":
                args=request.args.to_dict()
                ret = parse_cmd_args(args)
                return ret