#!/bin/bash
set -e

# runs supervisord detached,
# the default ubuntu "/etc/supervisor/supervisord.conf" config file
# tries to load "/etc/supervisor/conf.d/*.conf"
supervisord -c /etc/supervisor/supervisord.conf

# if a some command has been passed to container, executes it and exit,
# otherwise runs bash
if [[ $@ ]]; then 
    eval $@
else 
    /bin/bash
fi
