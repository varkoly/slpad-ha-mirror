#!/bin/bash

echo "totem {
        version:        2
        crypto_cipher: none
        crypto_hash: none
        clear_node_high_bit: yes
        interface {
                ringnumber: 0
                bindnetaddr: 192.168.100.0
                mcastaddr: 226.94.1.1
                mcastport: 5405
                ttl: 1
        }
}

logging {
        to_stderr: no
        to_logfile: yes
        logfile: /var/log/cluster/corosync.log
        to_syslog: yes
        debug: off
        timestamp: on
        logger_subsys {
                subsys: QUORUM
                debug: off
        }
}

quorum {
        provider: corosync_votequorum
        expected_votes: 2
}
" > /etc/corosync/corosync.conf

corosync-keygen -l

scp /etc/corosync/authkey /etc/corosync/corosync.conf node2:/etc/corosync/

