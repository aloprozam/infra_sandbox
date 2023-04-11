from flask import Flask
from healthcheck import HealthCheck, EnvironmentDump
import socket

app = Flask(__name__)

health = HealthCheck()
envdump = EnvironmentDump()
hostname=socket.gethostname()   
IPAddr=socket.gethostbyname(hostname)  

@app.route('/',methods=['GET'])
def index_page():
    if IPAddr != None :
        return {"hostname": hostname,
                "host_ip": IPAddr,
                "status": "UP"}
    else:
        return {"hostname": hostname,
                "host_ip": IPAddr,
                "status": "DOWN"}

health.add_check(index_page)

@app.route('/healthcheck',methods=['GET'])
def health_page():
    return health.run()

@app.route('/environment',methods=['GET'])
def envdump_page():
    return envdump.run()
