from flask import Flask, render_template
from ctypes import CDLL, c_void_p, c_int

app = Flask(__name__)

# Load the C shared library
led_control = CDLL('./led_control.so')

# Function prototype
led_control.control_led.argtypes = [c_int]
led_control.control_led.restype = None

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/control_led/<int:led_state>')
def control_led(led_state):
    # Call the C function to control the LED
    led_control.control_led(led_state)
    return f"LED State set to {led_state}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
