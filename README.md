# ros-docker-setup

# What / Why
This repo contains a setup to run [ROS Noetic](http://wiki.ros.org/noetic) with graphical applications (e.g. [rviz](http://wiki.ros.org/rviz) and [Gazebo](https://gazebosim.org)) from in a docker container.

It's originally created for the [CS 588](http://luthuli.cs.uiuc.edu/~daf/courses/MAAV-21/588-2021-home.html) class at UIUC, but it can be useful in other similar settings. I had to run a set of ROS packages (with Gazebo for simulation and rviz for visualization) built on top of ROS Noetic, but my own machine was unable to run ROS Noetic due to it having an older version of linux (ROS Noetic requires Ubuntu 20).

# Usage
Docker and the NVIDIA Container Toolkit (`nvidia-docker2`) are required for this to work. Here's some installation instructions:
- Docker: https://docs.docker.com/engine/install/ubuntu/
- NVIDIA Container Toolkit: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#setting-up-nvidia-container-toolkit

To run the script:
```
./run.sh <path_to_ros_workspace_on_host>
```

It will first build a docker image called `cs588-ros-simulator:latest` based on the `Dockerfile` in this repo. Then, it will start a docker container using that image that is able to run ROS Noetic, rviz, and Gazebo with working GUIs. The `<path_to_ros_workspace_on_host>` will be mounted as `/root/workspace` in the docker container, so the files in the ROS workspace will be accessible / reusable even after the container has exited.

# Demo
Demo video link: https://youtu.be/e3t--Cn2jRw

# Useful Sources
Here's some of the very helpful sources I used to get this working:
- http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration
- https://answers.ros.org/question/300113/docker-how-to-use-rviz-and-gazebo-from-a-container/?answer=356287#post-id-356287
- https://github.com/NVIDIA/nvidia-docker/issues/1388#issuecomment-703127624
