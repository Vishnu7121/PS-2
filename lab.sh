#!/bin/bash
sudo apt-get update
sudo apt-get update && sudo apt-get install -y docker.io
sudo apt-get install -y docker-compose
sudo apt-get update && sudo apt-get install -y ant

# sudo apt install mysql-server-5.7

# Install Docker
# echo "Installing Docker..."
# curl -fsSL https://get.docker.com -o get-docker.sh
# sudo sh get-docker.sh
# sudo usermod -aG docker "$USER"
# sudo systemctl enable docker
# sudo systemctl start docker

# # Install Docker Compose (version 1.26.2)
# echo "Installing Docker Compose..."
# sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

# # Install Ant 1.10.12
# echo "Installing Ant 1.10.12..."
# sudo apt-get update
# sudo apt-get install -y ant

# Install Git
echo "Installing Git..."
sudo apt-get install -y git
DIR=./srikanth

if [ -e "$DIR" ]; then
   sudo rm -rf "$DIR"
fi

if [ -d "$DIR" ]; then
    echo "Directory exists"
else
    sudo mkdir "$DIR"
fi

cd "$DIR" || exit

echo "Cloning SQL-Injection"
sudo git clone https://github.com/Vishnu7121/SQL-Injection.git

cd ./SQL-Injection/ || exit

sudo ant -d clean compile dist
# Add code to execute the DB_INIT.SQL file
# echo "Executing the DB_INIT.SQL script"
# sudo mysql -u srikanth -p17121981 -e "DROP DATABASE IF EXISTS demo1; CREATE DATABASE demo1; USE demo1; $(cat ./DB_INIT.SQL)"

result=$(sudo docker images -q sql-injection_web)

if [[ -n "$result" ]]; then
    echo "Image exists"
    sudo docker-compose down --volume --rmi all
else
    echo "No such image"
fi

# # Build the Docker image
# echo "Building the Docker image"
# sudo docker-compose build

# # Create the test.war file
# echo "Creating test.war file..."
# sudo touch ./dist/test.war
# Start the Docker containers
echo "Starting the Docker containers"
sudo docker-compose up -d
sudo docker-compose up -d
