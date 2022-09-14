#!/bin/sh
# Compile, Run and extract trace from matmul kernel

export PIN_ROOT=/home/ajay/Documents/CSE_530/Assignments/assignment_1/question/content/pin-3.18-98332-gaebd7b1e6-gcc-linux/
msize=${1:-'10'}
nsize=${2:-'10'}
num_matrices=${3:-'1'}
sparsity=${4:-'50'}
input_file=${5:-'input_matrix.in'}
generate_again=${6:-'false'}
build_type=${7:-'normal'}

echo "Arguments:"
echo $msize, $nsize, $num_matrices, $sparsity, $input_file, $generate_again, $build_type

if  [[ $generate_again = "true" ]];
then
  echo "Running random matrix generator"
  python utils/random_matrix_generator.py --m $msize --n $nsize --dump $input_file --sparsity $sparsity --numOfMatrices $num_matrices
else
  echo "Skipping random matrix generation"
fi

if [[ $build_type = "clean" ]];
then
    echo 'clean build'
    rm -rf bin/
    rm -rf traces/
    # delete logs 
    find ./Simulator/logs/ -name '*.log' -type f -delete
    find ./Simulator/logs/ -name '*.pkl' -type f -delete
else
    echo 'recursive build'
fi

mkdir -p bin/
mkdir -p traces/

echo Compiling mat_column_wise_copy
g++ -Wall src/mat_column_wise_copy.cpp -o bin/mat_column_wise_copy.o
#g++ -std=c++98 -Wall -O3 -g src/mat_column_wise_copy.cpp -o bin/mat_column_wise_copy.o -pedantic

echo Compiling mat_transpose
g++ -Wall src/mat_transpose.cpp -o bin/mat_transpose.o

echo Compiling mat_gather
g++ -Wall src/mat_gather.cpp -o bin/mat_gather.o

echo Compiling mat_scatter
g++ -Wall src/mat_scatter.cpp -o bin/mat_scatter.o

read -n 1 -s -r -p "Press any key to continue"

for entry in bin/*.o
do
  f=$(echo "${entry##*/}");
  kernelname=$(echo $f| cut  -d'.' -f 1);
  filename="${kernelname}_traces.out"
  if [[ $kernelname = "matmul_csr" ]];
  then
	echo "Passing matrix in csr fmt"
  	echo "Running $kernelname on $input_file"
	csrA="csrA_${input_file}"
	csrB="csrB_${input_file}"
  	time $PIN_ROOT/pin -t $PIN_ROOT/source/tools/ManualExamples/obj-intel64/pinatrace.so -- $entry $csrA $csrB
  elif [[ $kernelname = "matmul_smash" ]];
  then 	
	echo "Passing matrix in csr fmt"  
  	echo "Running $kernelname on $input_file"
	csrA="csrA_${input_file}"
	csrB="csrB_${input_file}"
  	time $PIN_ROOT/pin -t $PIN_ROOT/source/tools/ManualExamples/obj-intel64/pinatrace.so -- $entry -f 2 -s 2 -t 2 -i $csrA -k $csrB
  else 
	echo "Passing matrix in dense fmt"
  	echo "Running $kernelname on $input_file"
  	time $PIN_ROOT/pin -t $PIN_ROOT/source/tools/ManualExamples/obj-intel64/pinatrace.so -- $entry --input_file $input_file
  fi
  head pinatrace.out  
  mv pinatrace.out traces/$filename  
done

source run_simulator.sh /home/ajay/Documents/CSE_530/Assignments/assignment_1/question/content/CachePerformanceOnMatMul/traces
