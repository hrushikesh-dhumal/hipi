#! /bin/bash
echo
echo
echo "*******************Cleaning tools******************"
cd ~/hipi
gradle clean tools:hibImport:jar

echo "*******************Downloading data******************"
cd ~/
wget http://149.165.159.58/data/FG491/hdhumal/INRIAPerson.tar
tar -xvf ~/INRIAPerson.tar

echo
echo
echo "*******************Building tools******************"
cd ~/hipi/tools
gradle hibImport:jar


echo
echo
echo "*******************Downloading data******************"
cd ~/
wget http://149.165.159.58/data/FG491/hdhumal/INRIAPerson.tar
tar -xvf ~/INRIAPerson.tar

echo
echo
echo "*******************Configuring hadoop**************"
hdfs dfs -rm -r /input
hdfs dfs -rm -r sampleimages_average
hdfs dfs -mkdir /input
sh ~/hipi/tools/hibImport.sh ~/hipi/testdata/testimages/ /input/sampleimages.hib

echo
echo
echo "*******************Building Project****************"
cd ~/hipi/examples/helloWorld
gradle jar

echo
echo
echo "******************Executing Project****************"
hadoop jar ~/hipi/examples/helloWorld/build/libs/helloWorld.jar /input/sampleimages.hib sampleimages_average
hadoop fs -cat sampleimages_average/part-r-00000
