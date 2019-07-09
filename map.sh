#!/bin/bash

#size in blocks
MAP_WIDTH=1
MAP_LENGTH=1

MAP_BLOCK_SIZE=10

declare -a HORIZONTAL_WALLS
declare -a VERTICAL_WALLS

HORIZONTAL_WALLS=(
    [0]=1
    [1]=1
)

VERTICAL_WALLS=(
    [0]=1
    [1]=1
)

get_wall_index()
{
    local x_coord=${1}
    local y_coord=${2}
    case ${3} in
        left) return $((y_coord * (MAP_WIDTH + 1) + x_coord));;
        right) return $((y_coord * (MAP_WIDTH + 1) + x_coord + 1));;
        bottom) return $((x_coord * (MAP_HEIGHT + 1) + y_coord));;
        top) return $((x_coord * (MAP_HEIGHT + 1) + y_coord + 1));;
    esac
}

find_intersection()
{
    local camera_x=${1}
    local camera_y=${2}
    local angle=${3}

    local pos_x=${1}
    local pos_y=${2}
    local have_found=0

    # hack for now
    if [[ ${angle} -eq 90 ]]; then
        angle=89
    elif [[ ${angle} -eq 270 ]]; then
        angle=269
    fi

    if [ ${angle} -lt 90 ]; then
        . intersection_1.sh
    elif [ ${angle} -lt 180 ]; then
        . intersection_2.sh
    elif [ ${angle} -lt 270 ]; then
        . intersection_3.sh
    elif [ ${angle} -lt 360 ]; then
        . intersection_4.sh
    else
        echo 'INVALID ANGLE' ${angle}
    fi

    return ${distance}
}