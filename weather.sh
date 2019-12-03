#!/bin/bash
# Regular Colors
black='\033[1;30m'        # Black
red='\033[1;31m'          # Red
green='\033[1;32m'        # Green
yellow='\033[1;33m'       # Yellow
blue='\033[1;34m'         # Blue
purple='\033[1;35m'       # Purple
cyan='\033[1;36m'         # Cyan
white='\033[1;37m'        # White
gray='\033[1;37m'
r="\033[00m"

API="#"

a1="Made by : SOUMEN KHARA"
a2="GitHub : 50UM3N"

cloudy()
{
	echo -e "$blue     .--.	     $a1"
	echo -e "$blue  .-(    ).     $a2"
	echo -e "$blue (___.__)__)	$red"

}

fogg()
{
	echo -e "$blue _ - _ - _ -     $a1"
	echo -e "$blue  _ - _ - _      $a2"
	echo -e "$blue _ - _ - _ - $red"

}

rain()
{
	echo -e "$gray     .-.		"
	echo -e "$gray    (   ).     $a1"
	echo -e	"$gray  (___(__)     $a2"
	echo -e "$blue ‚ʻ‚ʻ‚ʻ‚ʻ"
	echo -e "$blue ‚ʻ‚ʻ‚ʻ‚ʻ$red"

}

partly_cloudy_day()
{

	echo -e "$yellow  \  /	"
	echo -e "$yellow""_'/''$blue.--.     $a1"
	echo -e "$yellow ,\_$blue(    ).     $a2"
	echo -e "$blue (___.__)__) $red"

}
sleet()
{
	echo -e "$white   .-.    "
	echo -e "$white  (   ).     $a1"
	echo -e "$white (___(__)     $a2"
	echo -e "$blue ʻ * ʻ *  "
	echo -e "$blue* ʻ * ʻ $red"

}
clear_day()
{
	echo -e "$yellow    \   /   "
	echo -e "$yellow     .-.      $a1"
	echo -e "$yellow  ‒ (   ) ‒     $a2"
	echo -e "$yellow     '-'     "
	echo -e "$yellow    /   \ $red"

}
wind()
{
	echo -e "     $blue.--.     $a1"
	echo -e "$white-------$blue  ).     $a2"
	echo -e "$white------$blue""__)__) $red"

}

deletelog()
{
	if [[ -e ip.log ]]
	then
		rm  ip.log
	fi
	if [[ -e weather.log ]]
	then
		rm  weather.log
	fi
}

getlocation()
{
#### using ip-tracker.org ######
#	ip=$(curl -s ifconfig.co)
#	iptracker=$(curl -s -L "www.ip-tracker.org/locator/ip-lookup.php?ip=$ip" --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" > ip.log)
#	s1=$(grep -o "City Lat/Lon:.*" ip.log | cut -b 42)
#	#echo -e "\n$s1\n"
#	if [[ $s1 = "-" ]]
#	then
#	    lat=$(grep -o "City Lat/Lon:.*" ip.log | cut -b 42-48)
#	    s2=$(grep -o "City Lat/Lon:.*" ip.log | cut -b 54)
#	#    echo -e "\n$s2\n"
#	    if [[ $s2 = "-" ]]
#	    then
#	        long=$(grep -o "City Lat/Lon:.*" ip.log | cut -b 54-60 )
#	    else
#	        long=$(grep -o "City Lat/Lon:.*" ip.log | cut -b 54-59)
#	    fi
#	else
#	    lat=$(grep -o "City Lat/Lon:.*" ip.log | cut -b 42-47)
#	    s2=$(grep -o "City Lat/Lon:.*" ip.log | cut -b 53)
#	#    echo -e "\n$s2\n"
#	    if [[ $s2 = "-" ]]
#	    then
#	        long=$(grep -o "City Lat/Lon:.*" ip.log | cut -b 53-59 )
#	    else
#	        long=$(grep -o "City Lat/Lon:.*" ip.log | cut -b 53-58)
#	    fi
#	fi
###### usng ifconfig.co/json ######
curl -s ifconfig.co/json > ip.log
lat=$(grep -o "latitude.*" ip.log | cut -d ":" -f 2 | cut -d "," -f 1)
long=$(grep -o "longitude.*" ip.log | cut -d ":" -f 2 | cut -d "," -f 1)
}

generatereport()
{
	getwlog=$(curl -s "https://api.darksky.net/forecast/$API/$lat,$long" >> weather.log )
	icon=$(grep -o "currently.*" weather.log | cut -d '"' -f11)
	location=$(grep -o "timezone.*" weather.log | cut -d'"' -f3)
	summary=$(grep -o "currently.*" weather.log | cut -d '"' -f7)
	atempf=$(grep -o "currently.*" weather.log | cut -d '"' -f24 | cut -d"," -f1 | cut -d":" -f2)
	utempf=$(grep -o "currently.*" weather.log | cut -d '"' -f26 | cut -d"," -f1 | cut -d":" -f2)
	dtempf=$(grep -o "currently.*" weather.log | cut -d '"' -f28 | cut -d"," -f1 | cut -d":" -f2)
	humidity=$(grep -o "currently.*" weather.log | cut -d '"' -f30 | cut -d"," -f1 | cut -d":" -f2)
	pre=$(grep -o "currently.*" weather.log | cut -d '"' -f32 | cut -d"," -f1 | cut -d":" -f2)
	windspeed=$(grep -o "currently.*" weather.log | cut -d '"' -f34 | cut -d"," -f1 | cut -d":" -f2)
	uvindex=$(grep -o "uvIndex.*" weather.log | cut -d ":" -f2 | cut -d "," -f 1)
	ozon=$(grep -o "ozone.*" weather.log | cut -d ":" -f2 | cut -d "}" -f 1)
}

prin()
{
	echo -e "$green""# $red""Temperature$white =$cyan $atempf °F\n$green""# $red""Apparent Temperature$white =$cyan $utempf °F\n$green""# $red""Dew Point$white =$cyan $dtempf°F\n$green""# $red""Humidity$white =$cyan $humidity\n$green""# $red""Preasure$white =$cyan $pre Hg"
	echo -e "$green""# $red""Wind Speed$white =$cyan $windspeed mph\n$green""# $red""UV Index$white =$cyan $uvindex\n$green""# $red""Ozon$white =$cyan $ozon"
}
generatelogo()
{
	echo -e "$red""$location"
	if [[ $icon = "partly-cloudy-day" || $icon = "partly-cloudy-night" ]]
	then
	    partly_cloudy_day
	elif [[ $icon = "clear-day" || $icon = "clear-night" ]]
	then
	    clear_day
	elif [[ $icon = "rain" ]]
	then
	    rain
	elif [[ $icon = "sleet" ]]
	then
	    sleet
	elif [[ $icon = "wind" ]]
	then
	    wind
	elif [[ $icon = "fog" ]]
	then
	    fogg
	elif [[ $icon = "cloudy" ]]
	then
	    cloudy
	fi
	toilet -f future  "$summary"
	}
clear
deletelog
getlocation
generatereport
paste <(generatelogo) <(prin) | column -s $'\t\t' -t
echo -e "$r"
