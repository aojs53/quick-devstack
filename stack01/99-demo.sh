# demo.sh - Devstack extras script to setup demo env

if [[ "$1" == "source" ]]; then
    :
elif [[ "$1" == "stack" && "$2" == "install" ]]; then
    :
elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
    cat <<EOF > /etc/neutron/dnsmasq-neutron.conf
dhcp-option-force=26,1400
EOF
elif [[ "$1" == "stack" && "$2" == "extra" ]]; then
    :
fi

if [[ "$1" == "unstack" ]]; then
    :
fi

if [[ "$1" == "clean" ]]; then
    :
fi
