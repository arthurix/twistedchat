#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m'

show_ip() {
    ip=$(ifconfig  | grep inet | awk '{print $2}' | head -1 | awk 'BEGIN{FS=":"}{print $2}')

echo -e $(cat <<EOF
\n\n\n
${GREEN}\n
 ---------------------------------------------\n
\n\n
    >>>>   Browse the web application  <<<<\n
    >>>>   using the data below        <<<<\n
${NC}\n
${YELLOW}\n
\t          http://$ip:3000\n
${NC}\n
${GREEN}\n
 ---------------------------------------------\n
${NC}
\n\n\n
EOF
)

}

cd /var/www/twistedchat/
bundle package --all --path='./cache'

/etc/init.d/postgresql restart
echo -e "${GREEN} RUNNING MIGRATIONS ${NC}"
rake db:create db:migrate

echo -e "${GREEN} RUNNING WEB APPLICATION ${NC}"
bin/rails server -p 3000 -e development -b 0.0.0.0&

show_ip

tail -f /var/www/twistedchat/log/development.log
cd /var/www/twistedchat
/bin/bash -l
