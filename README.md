# Druva Phoenix Docker container
A simple [Druva Phoenix](https://www.druva.com) container for Docker testing  

*Please note, this container will not allow full fledged use or access to a Druva Phoenix instance. This will simply afford you a simple containerized client for testing purposes with your own Druva Phoenix instance.*

## Example Usage
```
docker create \
-e PHOENIX_TOKEN="xxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxx" \
--name=phoenix \
1activegeek/druva_phoenix
```

## Environment Variables - with defaults listed
`-e PHOENIX_TOKEN=""` \
`-e PHOENIX_DOWNLOAD="https://downloads.druva.com/downloads/Phoenix/Linux/druva-phoenix-client-4.6.12-33654.amd64.deb"` \

## Current Limitation
Currently there is a limitation being worked on for automatic activation of the client upon launching the container. Unfortunately at this time, it requires a manual step after launching the container to finish the activation process. This can be achieved by typing the following into a command prompt after launching. Be sure to substitue `container-name` with your container name.

`docker exec -it container-name bash`

This will enter the container at the bash command shell. You should see the prompt will place you in `/opt/Druva/Phoenix/lib`. If it does not, you will need to navigate to this location using a `cd` command. Next you will run the Phoenix activation command:

`PhoenixActivate xxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

This should provide you a confirmation message after activation to confirm it was successful. At this point you should be able to log into the cloud console and see your newly registered server waiting to be configured. 

## Container Setup/Layout Info
There is no need to configure any specific ports to be opened. The way the app operates, it will be opening an outbound only connection to the cloud based servers. Once this persistent connection is made, backups will process as required without any further port openings.

Upon startup, the container will enter the required details into a config file which will be written. Once written, the container will then launch the inSync process in a virtual X session to allow the application to function as though it was installed on an ordinary Debian based desktop OS.

Optionally data can be mounted to locations as desired. By default a volume has been setup under `/opt/data` to be the designated location. If not mounted locally, it can be used as a volume to place test data for the container manually. Be sure to be aware of permissions as often Docker permissions don't line up perfectly with local permissions.
