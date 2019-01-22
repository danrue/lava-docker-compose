import serial
import time

class mrv(object):

    def __init__(self, port='/dev/ttyUSB0'):
        self.ser = serial.Serial(port=port,
                                 baudrate=38400,
                                 parity="N",
                                 stopbits=1,
                                 bytesize=8,
                                 timeout=8)
        assert self.ser.isOpen()
        self.ser.write(b"\r\n")
        self.ser.write(b"\r\n")
        time.sleep(1)
        assert self.ser.inWaiting()
        input_data = self.ser.read(self.ser.inWaiting())
        print(input_data)
        if b'In-Reach:' in input_data:
            return

        # Login
        assert b'Username' in input_data, input_data
        self.ser.write(b"Admn\r\n")
        time.sleep(1)
        self.ser.write(b"admn\r\n")
        time.sleep(1)
        input_data = self.ser.read(self.ser.inWaiting())
        print(input_data)
        assert b'In-Reach:' in input_data

    def command(self, command):
        self.ser.write(command+b'\r\n')
        time.sleep(1)
        print(self.ser.read(self.ser.inWaiting()))


ser = mrv()
ser.command(b'off .A1')
ser.command(b'off .A2')
ser.command(b'off .A3')
ser.command(b'off .A4')
ser.command(b'on .A1')
ser.command(b'on .A2')
ser.command(b'on .A3')
ser.command(b'on .A4')
