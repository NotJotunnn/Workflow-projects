#!/bin/zsh

# Accepts outside arg
file=$1

# Gets current directory breadcrumbs
cdw=$(pwd)

echo ""
echo "Trying to clear already existing group movement folders"

# Clears out any pre-existing packaging files
rm -d "./packagemv"

echo "Done."

# Moves into download directory
cd ~/Downloads

# # Gets download directory breadcrumbs
cdw2=$(pwd)

if [ -z "$1" ]; then
    echo
    echo "Do you wish to send all recent downloads into current directory? ( yes || y )"
    echo "To cancel operation, write anything but ( yes || y )"
    echo

    read ans

    echo

    if [ $ans = "yes" ] || [ $ans = "y" ]; then
        mkdir packagemv
        
        mv * packagemv/
        
        mv "$cdw2/packagemv" $cdw

        cd "$cdw/packagemv"

        mv * "$cdw"

        cd "../"

        rm -d "./packagemv"

        echo
        echo "Moved all recent Download files/folders to:"
        echo "$cdw"
        echo
        echo "Done."
        echo
    else
        echo "Done."
        echo
    fi
else
    if [[ $file == "."* ]]; then
            folder=$(echo $file | cut -c 2-255)
            mkdir $folder
            echo
            mv $(find *$folder) $folder
            echo
            mv -f "$cdw2/$folder" $cdw
            echo
            echo "Moved $folder files to new location: $cdw"
            echo
            echo "Done."
    else
        if [[ $file = *"." ]]; then
            folder=$(echo $file | cut -d"." -f1)
            mkdir $folder
            echo
            mv $(find $folder*) $folder
            echo
            mv -f "$cdw2/$folder" $cdw
            echo
            echo "Moved $folder files to new location: $cdw"
            echo
            echo "Done."
        else
            # Concatenates the download breadcrumb and the file name and then moves to current directory
            echo $file
            mv -f "$cdw2/$file" $cdw

            # Echos what was done
            echo
            echo "Move file: $cdw2/$file"
            echo "To new location: $cdw"
            echo
            echo "Done."
        fi
    fi
fi