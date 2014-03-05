systemctl stop slapd
rm -r /etc/openldap/slapd.d/*
rm /var/lib/ldap/*
yast2 auth-server
