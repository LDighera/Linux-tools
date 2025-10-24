# #!/bin/bash'
# temp-test.sh	This script runs heavy load and reports CPU temperature
# LGD: Sat 06 Jan 2024 11:55:59 AM PST	

set -xv		DEBUG

for F in {1..10}
do
  vcgencmd measure_temp
  # Sysbench command to factor prime numbers for 120 seconds, output suppressed
  sysbench cpu --cpu-max-prime=5000 --threads=4 --max-time=120 run 
#  sysbench cpu --cpu-max-prime=5000 --threads=4 --max-time=120 run >/dev/null 2>&1
done
  vcgencmd measure_temp
