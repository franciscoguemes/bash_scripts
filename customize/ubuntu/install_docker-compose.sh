####################################################################################################
# This script has to go after the install_docker script
#
#
####################################################################################################



# TODO: Documentiation and verify that the script works


# Unninstall docker compose in case of packet manager installation
sudo apt-get remove docker-compose

# Unninstall docker compose in case of manual installation (this script)
sudo rm /usr/local/bin/docker-compose



# Install docker-compose
DESTINATION=/usr/local/bin/docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
sudo chmod 755 $DESTINATION