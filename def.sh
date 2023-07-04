!/bin/bash

# Log file for capturing all output and errors in the home directory
LOG_FILE=~/def.log

# Function to log a message with a timestamp
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> "$LOG_FILE"
}

# Redirect standard output and standard error to the log file
exec > >(tee -a "$LOG_FILE")
exec 2> >(tee -a "$LOG_FILE" >&2)

log "Starting script..."

log "Changing directory to the home directory"
cd

log "Copying LoginService.java from S3"
aws s3 cp s3://sql/LoginService.java ~

log "Changing directory to the LoginService path"
cd srikanth/SQL-Injection/src/com/app/login

log "Removing existing LoginService.java"
sudo rm LoginService.java

log "Changing directory back to the home directory"
cd
sudo mv ~/LoginService.java srikanth/SQL-Injection/src/com/app/login/

cd

log "Changing directory to srikanth/SQL-Injection/"
cd srikanth/SQL-Injection/

log "Running 'sudo ant -d clean compile dist'"
sudo ant -d clean compile dist

result=$(sudo docker images -q sql-injection_web)
if [[ -n "$result" ]]; then
    log "Docker image exists. Stopping and removing existing containers."
    sudo docker-compose down --volume --rmi all
else
    log "No such Docker image found."
fi

log "Building the Docker image"
sudo docker-compose up -d

log "Script execution completed."
