#!/bin/sh
while getopts t:d:q: flag
do
    case $flag in 
        t) target=${OPTARG};;
        d) destination=${OPTARG};;
        q) quick="true";;
    esac
done

#Check if Directory Exists, if not creates it. Assigns desination
dest_folder = "${HOME}/Desktop/HTB/${destination}"

if test -d "${dest_folder}"
then
    echo "\033[0;32mDirectory Already Exists. Continuing on.\n"
    if test -d "${dest_folder}/nmap"
        then
            echo "\033[0;32mSubdirectory Exists. Starting Scan:\n"
        else
            echo "\033[1;33mCreating Sub Directory: nmap.\n \033[0;32mStarting scan\n"
            mkdir $dest_folder/nmap
    fi      
else
    echo "\033[1;33mCreating Directory: ${dest_folder}\n"
    mkdir $dest_folder
    mkdir $dest_folder/nmap
fi


echo "Scanning ${target}::${destination} with Quick Scan"
./quick_scan.sh ${target} > ${dest_folder}/nmap/quick_scan_${target}.txt
echo "Completed Quick Scan on ${target}::${destination}\n"

if test -z "$quick"
then
    #TCP Scan
    echo "Scanning ${target}::${destination} with TCP Scan"
    ./tcp_scan.sh ${target} > ${HOME}/Desktop/HTB/${destination}/tcp_scan_${target}.txt
    echo "Completed TCP Scan on ${target}::${destination}\n"
    
    #UDP Scan
    echo "Scanning ${target}::${destination} with UDP Scan"
    ./udp_scan.sh ${target} > ${dest_folder}/nmap/udp_scan_${target}.txt
    echo "Completed UDP Scan on ${target}::${destination}\n"
    
    #Full Scan
    echo "Scanning ${target}::${destination} with Full Scan"
    ./full_scan.sh ${target} > ${HOME}/Desktop/HTB/${destination}/full_scan_${target}.txt
    echo "Completed Full Scan on ${target}::${destination}\n"

    echo "Scans Finished."
    echo "Find all files at ${HOME}/Desktop/HTB/${destination}" 
else
    echo "Completed Quick Scab find all files at ${HOME}/Desktop/HTB/${destination}" 
fi
