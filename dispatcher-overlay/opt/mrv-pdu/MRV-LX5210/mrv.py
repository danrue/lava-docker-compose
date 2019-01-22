#!/usr/bin/env python3
import sys
import telnetlib
import time

class MRV(object):

    def __init__(self, host, username="Admn", password="admn"):
        self.tn = telnetlib.Telnet(host, timeout=2)
        self.tn.set_debuglevel(999)
        self.tn.read_until(b"Username: ", 2)
        self.tn.write(username.encode('ascii') + b"\n")
        self.tn.read_until(b"Password: ", 2)
        self.tn.write(password.encode('ascii') + b"\n")

    def reboot(self, port):
        self.tn.read_until(b"LX: ", 2)
        self.tn.write(b"off .a%d\n" % int(port))
        time.sleep(2)
        self.tn.read_until(b"LX: ", 2)
        self.tn.write(b"on .a%d\n" % int(port))
        time.sleep(2)

    def off(self, port):
        self.tn.read_until(b"LX: ", 2)
        self.tn.write(b"off .a%d\n" % int(port))
        time.sleep(2)

    def on(self, port):
        self.tn.read_until(b"LX: ", 2)
        self.tn.write(b"on .a%d\n" % int(port))
        time.sleep(2)

    # This doesn't work yet.
    #def status(self, port):
    ##    #self.tn.read_until(b"LX: ")
    #    print(self.tn.read_very_eager().decode('ascii'))
    #    self.tn.write(b"status .a6\n")
    #    print(self.tn.read_all().decode('ascii'))

if __name__ == "__main__":
    usage = "Usage: {} hostname port [reboot|off|on]".format(sys.argv[0])
    try:
        (prog, host, port, action) = sys.argv
    except:
        sys.exit(usage)

    mrv = MRV(host)
    getattr(mrv, action)(port)
