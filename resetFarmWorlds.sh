#!/bin/bash

declare -a FARMWORLDS=("farm_overworld" "farm_nether" "farm_end")
MARK2SERVERNAME=survival
WORLD_BORDER_DIAMETER=4000
WORLD_DIFFICULTY=hard

echo "This will reset the farmworlds. Press Enter to confirm!"
read confirm

echo "Make sure you're in the server directory when running this script. Press Enter to confirm"
read confirm

function runCommand {
    echo "Run command '$1'"
    mark2 send -n $MARK2SERVERNAME "$1"
}

# Remove old worlds
for world in "${FARMWORLDS[@]}"
do
   runCommand "mv delete $world"
   runCommand "mv confirm"
   echo "Waiting 30 seconds for world to delete"
   sleep 30
done

# Create new worlds
echo "Creating farm_overworld"
runCommand "mv create farm_overworld NORMAL"
sleep 30
echo "Creating farm_nether"
runCommand "mv create farm_nether NETHER"
sleep 30
echo "Creating farm_end"
runCommand "mv create farm_end END"
sleep 30

# Wait for worlds to generate
echo "Waiting additional 60 seconds for worlds to generate"
sleep 60

# Setup world settings
for world in "${FARMWORLDS[@]}"
do
   runCommand "mv modify set diff $WORLD_DIFFICULTY $world"
   runCommand "wbhelper $world $WORLD_BORDER_DIAMETER"
done
