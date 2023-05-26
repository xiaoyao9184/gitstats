#CODER BY xiaoyao9184 1.0
#TIME 2016-10-25
#FILE GITSTATS_PROJECT
#DESC run gitstats for git local repository project




#! /bin/sh




# v

tip=VCS-GITSTATS
ver=1.0
gitstatsPath=$(cd "$(dirname "$0")"; pwd)/gitstats
projectName=
gitPath=
reportPath=



# check

while [ ! -x "$gitstatsPath" ]; do
    read -p "Cant find $gitstatsPath, will clone form github?" yn
    case $yn in
        [Yy]* ) git clone https://github.com/hoxu/gitstats.git $gitstatsPath; break;;
        [Nn]* ) echo -n "Enter your gitstats path:"; read gitstatsPath;;
        * ) echo "Please answer yes or no.";;
    esac
done


# windows

if [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" -o "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # Do something under Windows NT platform
    if [ ! -x "$gitstatsPath/gitstats.py" ]; then
        echo "Shell in Windows, rename gitstats to gitstats.py"
        cp -v $gitstatsPath/gitstats $gitstatsPath/gitstats.py
        echo "Copy done"
    fi
fi


if [ -z ${gitPath} ]; then
    echo -n "Enter your git local repository path:"
    read gitPath
fi

if [ -z ${projectName} ]; then
    projectName=${gitPath##*/}
fi

if [ -z ${reportPath} ]; then
    reportPath=${gitstatsPath%/*}/$projectName
fi




# tip

echo "Your gitstats path is $gitstatsPath"
echo "Your project path is $gitPath"
echo "Your project name is $projectName"
echo "Your project report path is $reportPath"

echo "Running..."



#begin

cd $gitstatsPath

python ./gitstats $gitPath $reportPath




# end

read -n1 -r -p "Press any key to exit..." key
exit 0