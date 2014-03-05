#!/bin/bash
crm configure<<EOF
property no-quorum-policy=ignore
property stonith-enabled=no
primitive slapd_mirrormode ocf:heartbeat:slapd params\
                        slapd="/usr/lib/openldap/slapd" \
                        config="/etc/openldap/slapd.d/" \
                        user="ldap" group="ldap" \
                        services="ldap:/// ldaps:/// ldapi:///" \
                        watch_suffix="dc=example,dc=com" \
                        meta migration-threshold="3" \
                        op monitor interval=10s
clone ldap_clone slapd_mirrormode
primitive ldap-v_ip ocf:heartbeat:IPaddr2 params ip="192.168.101.200" nic="eth1" op monitor interval="5s" timeout="20s"
colocation v_ip_with_slapd inf: ldap-v_ip ldap_clone
order ip_before_slapd 
commit
EOF

