#!/bin/bash
if [ -d /opt/ros/kinetic ]; then
    . /opt/ros/kinetic/setup.bash
    export ROS_PARALLEL_JOBS=-j8
    export ROSLAUNCH_SSH_UNKNOWN=1
fi
