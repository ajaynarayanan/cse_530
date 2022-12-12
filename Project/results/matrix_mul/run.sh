#!/usr/bin/env bash

# Absolute path this script is in, thus /home/user/bin
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

# hotspot root path 
hotspot_dir="/home/grads/afs6372/project/HotSpot"
output_dir="$SCRIPTPATH/hotspot_outputs"

# Remove results from previous simulations
rm -f *.init
rm -rf $output_dir

# Create outputs directory if it doesn't exist
mkdir $output_dir

# HotSpot's grid model is capable of modeling stacked 3-D chips. To be
# able to do that, one has to specify what is called the 'Layer
# Configuration File' (LCF). An LCF specifies the set of vertical layers
# to be modeled including its physical properties (thickness,
# conductivity etc.) and the floorplan of the die in that layer.

# Let us now look at an example of how to model stacked 3-D chips. Let
# us use a simple, 3-block floorplan file 'floorplan1.flp' in addition to
# the more detailed original 'floorplan2.flp'. In the chip we will model, layer 0 is
# power dissipating silicon with a floorplan of 'floorplan1.flp', followed
# by a layer of non-dissipating (passive) TIM. This is then followed by
# another layer of active silicon with a floorplan of 'floorplan2.flp' and
# another layer of passive TIM. Such a layer configuration is described
# in 'fermi.lcf'. Note that the floorplan files of all layers are specified
# in the LCF instead of via the command line

for f in ./ptraces/*.ptrace; 
do 
    echo "Processing $f file..."; 
    filename=$(echo $f | cut -d "/" -f3 | cut -d "." -f1);
    echo "filename : $filename"
    mkdir $output_dir/$filename
    $hotspot_dir/hotspot -c fermi.config -p ./ptraces/$filename.ptrace -grid_layer_file fermi.lcf -materials_file fermi.materials -model_type grid -detailed_3D on -steady_file $output_dir/$filename/$filename.steady -grid_steady_file $output_dir/$filename/$filename.grid.steady

    # Copy steady-state results over to initial temperatures
    cp $output_dir/$filename/$filename.steady fermi.init

    # Transient simulation
    $hotspot_dir/hotspot -c fermi.config -p ./ptraces/$filename.ptrace -grid_layer_file fermi.lcf -materials_file fermi.materials -model_type grid -detailed_3D on -o $output_dir/$filename/$filename.ttrace -grid_transient_file $output_dir/$filename/$filename.grid.ttrace


    # Visualize Heat Map of Layer 0 and Layer 2 with Perl and with Python script
    python $hotspot_dir/scripts/split_grid_steady.py $output_dir/$filename/$filename.grid.steady 4 64 64
    echo "==== Running heat map generator for layer 0 and 2 === "
    python $hotspot_dir/scripts/grid_thermal_map.py floorplan1.flp $output_dir/$filename/"$filename"_layer0.grid.steady 64 64 $output_dir/$filename/"$filename"_layer0.png

    python $hotspot_dir/scripts/grid_thermal_map.py floorplan2.flp $output_dir/$filename/"$filename"_layer2.grid.steady 64 64 $output_dir/$filename/"$filename"_layer2.png
    # ../../../scripts/grid_thermal_map.pl floorplan2.flp outputs/matrix_mul_layer2.grid.steady 8 8 > outputs/layer2.svg
done