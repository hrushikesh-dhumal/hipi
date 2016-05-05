#! /bin/bash
echo
echo
echo "*******************Cleaning tools******************"
gradle clean tools:hibImport:jar

echo
echo
echo "*******************Building tools******************"
cd tools
gradle hibImport:jar

echo
echo
echo "*******************Configuring hadoop**************"
hdfs dfs -rm -r /input
hdfs dfs -rm -r sampleimages_average
hdfs dfs -mkdir /input
./hibImport.sh ./../testdata/testimages/ /input/sampleimages.hib

echo
echo
echo "*******************Building Project****************"
cd ./../examples/helloWorld
gradle jar

echo
echo
echo "******************Executing Project****************"
hadoop jar build/libs/helloWorld.jar /input/sampleimages.hib sampleimages_average
hadoop fs -cat sampleimages_average/part-r-00000
