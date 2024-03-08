# toggle_functions.sh
# K. de Vos 2024

toggle_state() {
    local toggle_file="$HOME/.ROS_toggle_state"
    local toggle_state

    # Initialize the toggle variable (0 for OFF, 1 for ON)
    if [ -e "$toggle_file" ]; then
        toggle_state=$(cat "$toggle_file")
    else
        toggle_state=1
        echo "$toggle_state" > "$toggle_file"
    fi

    echo "$toggle_state"
}

# Function to toggle the state
toggle_ROS() {
    local toggle_file="$HOME/.ROS_toggle_state"
    toggle_state=$(cat "$toggle_file")

    if [ -z "$1" ]; then
        :
    elif [ "$1" -eq 0 ]; then
        toggle_state=0
    elif [ "$1" -eq 1 ]; then
        toggle_state=1
    elif [ "$1" -eq 2 ]; then
        toggle_state=2
    fi

    if [ "$toggle_state" -eq 1 ]; then
        echo "Sourced ROS 1"
        source /opt/ros/noetic/setup.bash
        # Add commands to execute when toggle is ON
        toggle_state=1
    elif [ "$toggle_state" -eq 2 ]; then
        echo "Sourced ROS 2"
        source /opt/ros/foxy/setup.bash
        # Add commands to execute when toggle is OFF
        toggle_state=2
    elif [ "$toggle_state" -eq 0 ]; then
        echo "Sourced NO ROS"
        # Add commands to execute when toggle is OFF
        toggle_state=0
    fi
    # Save the toggle state to the file
    echo "$toggle_state" > "$HOME/.ROS_toggle_state"
}
