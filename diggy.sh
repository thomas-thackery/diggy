#!/bin/bash

# Action: Gets A and AAAA records from Pantheon *platform domain* 
# Use case: Some customers cannot use CNAMEs for their
#  subdomains and need IP addresses. This outputs the A and AAAA records 
#  in a way that can copied and pasted for the customer. 
# Approach comes frome DTS
# Inputs: Platform domain with or without http:// and trailing / 
# Output: 
# A     <IP Address>
# AAAA  <IP Address>
# AAAA  <IP Address>
#
# Special thanks to Albert for nudges and edits

echo 'Enter the PLATFORM domain you need A and AAAA records for (typically live)';
read SITE;

# Clean url of protocol and / replacement---could be rewritten
http="http://";
SITE=${SITE/$http/};
https="https://";
SITE=${SITE/$https/};
SITE=${SITE/\//};

#A Record
printf "A\t" & dig $SITE +short | tail -1  

AAAA_output=$(dig aaaa $SITE +short);
#echo $AAAA_output

#AAAA Records
printf "AAAA\t%s\n" $AAAA_output | sed -n "2,1p"
printf "AAAA\t%s\n" $AAAA_output | sed -n "3,1p"
