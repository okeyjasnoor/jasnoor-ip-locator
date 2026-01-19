#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

IP=$1
RESPONSE=$(curl -s "http://ip-api.com/json/$IP")

get_value() {
    echo "$RESPONSE" | grep -o "\"$1\"[^,}]*" | cut -d':' -f2- | tr -d '"' 
}

STATUS=$(get_value status)

if [ "$STATUS" != "success" ]; then
    echo "Invalid IP or API error"
    exit 1
fi

echo "=============================="
echo " IP GEOLOCATION REPORT"
echo "=============================="

echo "[ Location ]"
echo "Continent     : $(get_value continent) ($(get_value continentCode))"
echo "Country       : $(get_value country) ($(get_value countryCode))"
echo "Region        : $(get_value regionName) ($(get_value region))"
echo "City          : $(get_value city)"
echo "ZIP Code      : $(get_value zip)"

echo
echo "[ Coordinates ]"
echo "Latitude      : $(get_value lat)"
echo "Longitude     : $(get_value lon)"

echo
echo "[ Time & Currency ]"
echo "Timezone      : $(get_value timezone)"
echo "UTC Offset    : $(get_value offset)"
echo "Currency      : $(get_value currency)"

echo
echo "[ Network ]"
echo "ISP           : $(get_value isp)"
echo "Organization  : $(get_value org)"
echo "ASN           : $(get_value as)"
echo "AS Name       : $(get_value asname)"

echo
echo "[ Connection Flags ]"
echo "Mobile        : $(get_value mobile)"
echo "Proxy         : $(get_value proxy)"
echo "Hosting       : $(get_value hosting)"

echo
echo "=============================="

