#!/bin/bash
. /lib/lsb/init-functions
. /etc/asd.conf

export DAEMON_FILE=/run/asd
export DAEMON='/usr/bin/anything-sync-daemon'

case "$1" in
    start)
        log_daemon_msg 'Starting Anything-Sync-Daemon'
        start-stop-daemon --start --quiet --exec $DAEMON -- sync
        log_end_msg $?
        ;;
    stop)
        log_daemon_msg 'Stopping Anything-Sync-Daemon'
        start-stop-daemon --stop --quiet --oknodo --exec $DAEMON -- unsync
        log_end_msg $?
        ;;
    sync)
        log_daemon_msg 'Doing a user requested sync'
        if [[ -f $DAEMON_FILE ]]; then
            /usr/bin/anything-sync-daemon sync
            log_end_msg $?
        else
            log_end_msg 1
        fi
        log_end_msg 0
        ;;
    *)
        echo "usage $0 {start|stop|sync}"
        ;;
esac
exit 0
