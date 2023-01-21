# Jenkins container with docker installed

Use Jenkins in your local machine from a docker container, being able to use docker inside Jenkins and persisting. This guide was made using the `Ubuntu-22.04` distro on `WSL 2` (make sure you can use docker from that distro).

In Windows follow the same steps but run the `jenkins-docker-windows.sh` script instead.

---

## Build the jenkins image with docker installed

In your terminal go to the directory where the Dockerfile is and run:

```bash
docker build -t jenkins:lts-docker .
```

you can change the tag of the image from `jenkins:lts-docker` to anything else, but you'll have to modify the `jenkins-docker.sh` script too.

---

## Run Jenkins in a docker container

The `jenkins-docker.sh` script starts a Jenkins container that has access to the host's Docker daemon, using a named volume for its home directory, and exposing the default Jenkins ports to host machine.

You can execute it using `bash jenkins-docker.sh` or `./jenkins-docker.sh` if you have made it executable using `chmod +x jenkins-docker.sh`.

| Command                                       | Description                                                                                                                                               |
| :-------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------  |
| docker run                                    | Create and run a new container from a given image                                                                                                         |
| --rm                                          | Automatically removes the container when it exits                                                                                                         |
| -d                                            | Allows the container to run in the background while the command line is available for other tasks                                                         |
| --name jenkins-playground                     | Assigns the container the name `jenkins-playground`                                                                                                       |
| -v /var/run/docker.sock:/var/run/docker.sock  | Mounts the host's Docker socket inside the container, allowing the container to interact with the host's Docker daemon                                    |
| -v jenkins_home_volume:/var/jenkins_home      | Mounts a volume named `jenkins_home_volume` at the `/var/jenkins_home` path inside the container, which is the default location for Jenkins data          |
| --privileged                                  | Runs the container with extended privileges to allow it to perform tasks that would otherwise be restricted                                               |
| --user root                                   | Runs the container as the root user, rather than the default unprivileged user                                                                            |
| -p 8080:8080                                  | Maps port `8080` on the host to port `8080` on the container, allowing external traffic to access the Jenkins service running inside the container        |
| -p 50000:50000                                | Maps port `50000` on the host to port `50000` on the container, allowing external traffic to access the Jenkins JNLP service running inside the container |
| jenkins:lts-docker                            | The container image from which to run this container                                                                                                      |

## Configure the Jenkins instance

Go to `http://localhost:8080` on your browser, it will ask for the `Administrator password`. To get the password run

```bash
docker ps
```

and copy the `CONTAINER ID` of the `jenkins-playground` container, then execute

```bash
docker logs <CONTAINER ID>
```
replacing `<CONTAINER ID>` for the container ID.

In the terminal output look for something like this

> Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:

> `36mdaa41e7834b019f1fb8b10600976b`

> This may also be found at: /var/jenkins_home/secrets/initialAdminPassword

Copy the password and paste it in your browser in the field where it is required.

After entering the initial admin password, Jenkins will bring you to a `Customize Jenkins` page. Click the Install suggested plugins button. This will takes you to a loading screen displaying the progress as Jenkins installs the most popular plugins.

After that create the first `Admin User` filling in the requested data, `username`, `password`, etc. Click on Save and Continue and leave the default URL.

> NOTE: If you click `continue as admin` then the username will be `admin` and the password will be the initial `admin password` we found earlier.

From now on you just have to run the script every time you need to use Jenkins. Remember to stop the container when you're not using it, the next time you run the script you only need to login with the credentials of the admin user you created.

You can also install new plugins like `Templating Engine` or `Docker Pipeline`.
