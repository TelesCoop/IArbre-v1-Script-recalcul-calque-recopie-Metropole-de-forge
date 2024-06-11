#!/bin/sh

# Formatting log line
comment () {
  echo -e "\e[39m\t-> $1\e[39m"
}

# Check the last command return code (must be insterted just after the commend )
check () {
  if [ $? -eq 0 ]; then
   comment "\e[32mOk.\e[39m"
  else
   comment "\e[31mERROR !...\e[39m"
   exit 1
  fi;
}

######################################################################
# MAIN
######################################################################
# Cloning or de pulling data to calculate the calq 
if [ -d /arb-data/source-files/data-recalcul-calque/.git ]; then 
    comment "Entering in data directory..."
    cd /arb-data/source-files/data-recalcul-calque
    check
    comment "Pulling last version of data repo..."
    git pull origin main
    check
else 
    comment "This is the first time we run this script, we have to clone data repo..."
    mkdir -p /arb-data/source-files/data-recalcul-calque
    cd /arb-data/source-files
    comment "Cloning data..."
    git lfs clone https://$GIT_USERNAME:$GIT_PASSWORD@forge.grandlyon.com/erasme/sources-recalcul-calque.git ./data-recalcul-calque/;
    check
fi
echo "Data ready !"
exit 0
