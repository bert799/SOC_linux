from flask import Flask, render_template
from ctypes import CDLL

app = Flask(_name_)

# Load the C shared library
led_control = CDLL('./led_control.so')

# Function prototype
led_control.control_led.argtypes = [int, int]
led_control.control_led.restype = None

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/control_led/<int:led_state>')
def control_led(led_state):
    # Call the C function to control the LED
    led_control.control_led(virtual_base, led_state)
    return f"LED State set to {led_state}"

if _name_ == '_main_':
    # Set the virtual base address based on your setup
    # You may need to determine the correct address based on your DE10-Standard configuration
    virtual_base = 0xC0000000  # Replace with your actual virtual base address

    app.run(host='0.0.0.0', port=5000, debug=True)