#################################################
#						#
# 						#
# Check OpenIMS backend-error			#
# Versie 1.0					#
# 						#
# Copyright Vincent Lieftink			#
# MHASMO bv					#
#################################################

#!/bin/bash -x	

# Global variables:
PATH='/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
SCRIPT_PATH="${0}"

STATE_OK="0"
STATE_WARNING="1"
STATE_CRITICAL="2"
STATE_UNKNOWN="3"


# Controleer eerst of de logfile bestaat
if [ ! -f /var/tmp/logging/errors/`date +%Y%m%d`.log ]; then
   echo "Logfile /var/tmp/logging/errors/`date +%Y%m%d`.log does not exist."
   exit $STATE_UNKNOWN
fi

# Tel de regels met de keywords WORD_SelectNextConversionServer en ERROR op 1 regel.
ERROR="$(grep -E 'WORD_SelectNextConversionServer' /var/tmp/logging/errors/`date +%Y%m%d`.log | grep ERROR | wc -l)"


# Check-backend_errors
if [ $ERROR -gt 100 ]
then
	echo "CRITICAL! Backend-errors detected! = $ERROR | 'BACKEND-ERRORS'=$ERROR "
	exit ${STATE_CRITICAL} 
elif [ $ERROR -gt 50 ]
then
	echo "WARNING! Backend-errors detected! = $ERROR | 'BACKEND-ERRORS'=$ERROR"

	exit ${STATE_WARNING}
else
	echo "OK! Normal. No backend-errors detected = $ERROR | 'BACKEND-ERRORS'=$ERROR"
	exit ${STATE_OK}
fi
