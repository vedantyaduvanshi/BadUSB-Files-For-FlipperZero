# BAD USB DETECTION AND PROTECTION

**SYNOPSIS**

This script runs passively in the background waiting for any new usb devices.
When a new USB device is connected to the machine this script monitors keypresses for 30 seconds.
If there are 13 or more keypresses detected within 200 milliseconds it will pause all input for 10 seconds and attempt to disable the most recently connected USB device

**USAGE**

1. Run the script and follow instructions
2. A pop up will appear when monitoring is active and if a 'BadUSB' device is detected
3. logs are found in 'usblogs' folder in the temp directory.

**REQUIREMENTS**

Admin privlages are required for removing any suspected devices (you can re-enable devices too)
