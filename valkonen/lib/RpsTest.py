import requests

class RpsTest:
    ROBOT_LIBRARY_SCOPE = "SUITE"

    def __init__(self, url):
        self.base_url = url
    
    def set_pin_state_with_username(self, usr, pwd, pin, state):
        data  = { "username": usr, "password": pwd }
        data[pin] = int(state)
        res = requests.post(self.base_url, json=data, timeout=1)

        if res.status_code == 200:
            return "OK"
        
        return "Access Denied"

    def get_pin_state_with_username(self, usr, pwd):
        data  = { "username": usr, "password": pwd }
        res = requests.get(self.base_url, json=data, timeout=1)

        if res.status_code == 200:
            return res.json()
        
        return "Access Denied"