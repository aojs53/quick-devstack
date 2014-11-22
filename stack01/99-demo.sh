# demo.sh - Devstack extras script to setup demo env

if [[ "$1" == "source" ]]; then
    :
elif [[ "$1" == "stack" && "$2" == "pre-install" ]]; then
    sudo apt-get -y install gettext
elif [[ "$1" == "stack" && "$2" == "install" ]]; then
    :
elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
    cat <<EOF > /etc/neutron/dnsmasq-neutron.conf
dhcp-option-force=26,1400
EOF
elif [[ "$1" == "stack" && "$2" == "extra" ]]; then
    :
    pofile=/usr/local/lib/python2.7/dist-packages/openstack_auth/locale/ja/LC_MESSAGES/django.po
    mofile=/usr/local/lib/python2.7/dist-packages/openstack_auth/locale/ja/LC_MESSAGES/django.mo
    if [ -f $pofile ]; then
        sudo msgfmt -o $mofile $pofile
    fi
    sudo service apache2 reload
fi

if [[ "$1" == "unstack" ]]; then
    :
fi

if [[ "$1" == "clean" ]]; then
    :
fi
