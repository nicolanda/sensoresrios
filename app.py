from flask import Flask, jsonify, request
from flask_cors import CORS
import pg8000

db = pg8000.connect(database='d5i4dbpff3htlh', user='dpqajkuapfamfg', password='25a37c8cb43391f3d8b987fc278a4e363cd930a3a0d2acfe7a96ba2bf2f0709f', host='ec2-18-204-74-74.compute-1.amazonaws.com', port='5432')
app = Flask(__name__)
CORS(app)

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/add_device', methods = ['POST'])
def add_device():
    if request.method == 'POST':
        data = request.get_json(silent=True)
        sensor_id = data['sensor_id']
        ip = data['device_ip']

        query = "INSERT INTO devices (sensor_id, ip) VALUES ('{}', '{}');".format(sensor_id, ip)
        
        db.run(query)
        db.commit()
        return 'Device succesfully added'
    else:
        return 'Method not supported'

@app.route('/recieve_readings', methods = ['POST'])
def recieve_readings():
    if request.method == 'POST':
        if 'data' in request.args.keys():
            print("Estoy en data")
            data = request.args.get('data')
            sensor_id, dix, time = map(str, data)
            db.run("INSERT INTO readings (sensor_id, dix, time) VALUES ('{}', '{}', '{}')".format(sensor_id, dix, time))
            db.commit()
            return 'Data succesfully inserted into the database'
        
        elif 'files' in request.args.keys():
            print("Estoy en files")
            data = request.args.get('files')
            readings = data.split('\n')
            print(readings)
            for i in readings:
                read_data = i.split('_')
                print(read_data)
                sensor_id, dix, time = map(str, read_data)
                db.run("INSERT INTO readings (sensor_id, dix, time) VALUES ('{}', '{}', '{}')".format(sensor_id, dix, time))
                db.commit()
            return 'Data succesfully inserted into the database'

    return 'None'

@app.route('/show_readings', methods = ['GET'])
def show_readings():
    print(request.args)
    if 'sensor_id' in request.args.keys():
        sensor_id = request.args.get("sensor_id")
        quantity = request.args.get("quantity")
        data = db.run("SELECT * FROM readings WHERE sensor_id = '{}' ORDER BY time DESC LIMIT '{}'".format(str(sensor_id), str(quantity)))
        return jsonify(data)

    else:
        quantity = request.args.get("quantity")
        return jsonify(db.run("SELECT * FROM readings ORDER BY time DESC LIMIT '{}';".format(str(quantity))))

if __name__ == '__main__':
    app.run(host='localhost')