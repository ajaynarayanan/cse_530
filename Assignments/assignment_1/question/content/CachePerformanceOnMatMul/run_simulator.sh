#!/bin/sh
# Run Simulator on input traces 

input_file=${1:-'traces/'}   #Pass absolute path
cd Simulator/src/

for entry in $input_file/*.out
do
  f=$(echo "${entry##*/}");
  echo $entry, $input_file
  tracename=$(echo $f| cut  -d'.' -f 1);
  # remove '_traces' from tracename
  experimentName=${tracename::-7}
  filename="${tracename}_stats.out"
  for config_path in ../config/${experimentName}/*
  do
    echo "Running $tracename on simulator with $config_path"
    config_name=$(echo $config_path| grep -o '[^/]*$');
    time ./cache_simulator.py -c "${config_path}" -t $entry -l "../logs/${experimentName}/${config_name}.log"
  done
  
done
cd -
