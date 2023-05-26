# Kev's build script
HERE=$PWD

IMAGE_STATE=$(docker images -q bash2py:latest 2> /dev/null)
RUN_STATE=$(docker ps -qf "ancestor=bask2py")

create_docker_image () {
  if [[ "$IMAGE_STATE" == "" ]]; then
    docker build -t bash2py .
  fi
}

run_docker_container () {
  if [[ "$RUN_STATE" == "" ]]; then
    echo "Spinning up new bash2py container"
    docker run --rm --name bash2py --cap-add sys_ptrace --mac-address="de:ad:be:ef:00:03" -p127.0.0.1:2322:22 -d -v "$HERE:/host" bash2py
    sleep 2

    # update running state image id to be the newly created Docker container
    RUN_STATE=$(docker ps -qf "ancestor=bash2py")

    ssh-keygen -f "$HOME/.ssh/known_hosts" -R [localhost]:2322
  fi

  echo "Rejoining bash2py container $RUN_STATE"
  docker exec -i -t "$RUN_STATE" /bin/bash
}
