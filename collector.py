import serial, time, json

hw_sensor = serial.Serial(port='COM5', baudrate=115200, timeout=1, write_timeout=1)
f = open('data.csv','w', newline='')
if __name__ == '__main__':

    print(time.time())
    while True:
        try:
            if(hw_sensor.readline().decode('utf-8') != ""):
                data = hw_sensor.readline()
                print(data)
                data_decoded = data.decode('utf-8')
                print(data_decoded)
                data_decoded = str(time.time()) +','+data_decoded
                f.write(data_decoded) 
        except:
            print("Data collection stopped")
            hw_sensor.close()
            f.close()
            break
 