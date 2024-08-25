#!/bin/bash

echo ""
echo "----------"
echo "This bash script recursively goes through every PNG file in a given folder"
echo "and removes its alpha channel. This is useful for preparing PNG files for"
echo "uploading to Apple's iOS App Store."
echo ""
echo "You'll know you might need to use this script if you see this error coming"
echo "from Apple when you try to upload the images:"
echo ""
echo " >> Images can't contain alpha channels or transparencies."
echo ""
echo "This script uses imagemagick per https://stackoverflow.com/a/29178945"
echo ""
echo "Usage: "
echo ""
echo " ./stripAlphaChannelFromPNGs.sh PATH_TO_FILES"
echo "----------"
echo ""

TARGET_DIRECTORY="$1"

RED='\033[0;31m' # Red Color
NC='\033[0m' # No Color

if [ -z "$1" ]
then
    echo -e "${RED}ERROR:${NC} You didn't provide a path to the files. See the usage above and try again."
    echo ""
    exit
fi

echo -e "${RED}WARNING:${NC} This will edit every PNG file in this folder and all subfolders: $TARGET_DIRECTORY"
echo ""
read -p "Are you sure you want to continue? (Please type 'yes' to confirm): " confirm

if ! [ "$confirm" == "yes" ]
then
    echo ""
    echo -e "${RED}ERROR:${NC} Confirmation was not received. Exiting program now without editing any PNG files."
    echo ""
    exit
fi

echo ""
echo "Starting..."

find "$TARGET_DIRECTORY" -type f \( -name '*.png' -o -name '*.PNG' \) -print0 | 
while IFS= read -r -d '' file; do
    echo "Removing Alpha Channel From: $file"
    mogrify -alpha off "$file"
done

echo "Completed"
