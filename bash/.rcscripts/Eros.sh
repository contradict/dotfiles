#!/bin/bash
if [ -d /opt/ros/indigo ]; then
    . /opt/ros/indigo/setup.bash
    export ROS_PARALLEL_JOBS=-j8
    export ROSLAUNCH_SSH_UNKNOWN=1
fi
