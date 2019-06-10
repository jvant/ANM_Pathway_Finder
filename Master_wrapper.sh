#!/bin/bash

# Enter inputs here

echo 'Enter the path & file name of end state 1 pdb'
read end_state_1_pdb
echo 'Enter the path & file name of end state 2 pdb'
read end_state_2_pdb
echo 'Thank you!  Let us get started.'

# Compile Fortran programs

echo ' '
echo 'Started compiling!'
echo ' '

cd step-1-find-initial-point
make
cd ../step-2-minimize-on-cusp
make
cd ../step-3-slide-down
make
cd ../step-4-collect-structures
make
cd ../step-5-make-pathway
make
cd ../
echo ' '
echo 'Software has been compiled!'
echo ' '

# Step 0
pwd
vmd -dispdev text -eofexit < make_INPUT_INFO_FILE.tcl -args $end_state_1_pdb $end_state_2_pdb

vmd -dispdev text -eofexit < prepare_input_strucutre_files.tcl

# Step 1
echo " "
echo 'Starting step 1'
echo " "
cd ./step-1-find-initial-point/
cp ../INPUT_STRUCTURE_1 .
cp ../INPUT_STRUCTURE_2 .
vmd -dispdev text -eofexit < ./make_INPUT_FIND_STRUCTURES_ON_CUSP.tcl -args ../1_CA.pdb
./1_locate_struct_on_cusp
echo " "
echo 'Step 1 is done'
echo " "
cd ../

# Step 2
echo " "
echo 'Starting step 2'
echo " "
cd ./step-2-minimize-on-cusp 
cp ../INPUT_STRUCTURE_1 .
cp ../INPUT_STRUCTURE_2 .
cp ../step-1-find-initial-point/initial_struct_on_cusp .
cp ../REFERENCE_FOR_ALIGNMENT .
vmd -dispdev none -eofexit < make_INPUT_MINIMIZE_ON_CUSP.tcl -args ../1_CA.pdb
./2_find_min_on_cusp_v3
echo " "
echo 'Step 2 is done'
echo " "
cd ../

# Step 3
echo " "
echo "Starting step 3"
echo " "

cd ./step-3-slide-down 
cp ../INPUT_STRUCTURE_1 .
cp ../INPUT_STRUCTURE_2 .
cp ../step-2-minimize-on-cusp/minimized_struct_on_cusp .
cp ../REFERENCE_FOR_ALIGNMENT .
vmd -dispdev text -eofexit < make_INPUT_SLIDE_ONE_SURFACE.tcl -args ../1_CA.pdb
./3_desc_one_surface_v2

echo " "
echo "Starting step 3 second decent"
echo " "
sed -i s/SURFACE_INDEX\ 1/SURFACE_INDEX\ 2/ INPUT_SLIDE_ONE_SURFACE
./3_desc_one_surface_v2
cd ..
echo " "
echo "Step 3 is done"
echo " "

# Step 4
echo " "
echo "Starting step 4"
echo " "
cd ./step-4-collect-structures
cp ../INPUT_STRUCTURE_1 .
cp ../INPUT_STRUCTURE_2 .
cp ../REFERENCE_FOR_ALIGNMENT .
cp ../step-2-minimize-on-cusp/minimized_struct_on_cusp .
cp ../step-3-slide-down/OUT_COORDS_SURFACE* .
cp ../step-3-slide-down/num_structures_written* .
vmd -dispdev text -eofexit < make_INPUT_COLLECT_ENERGY.tcl -args ../1_CA.pdb
./4_collec_ener
cd ..
echo " "
echo "Step 4 is done"
echo " "

# Step 5
echo " "
echo "Start step 5"
echo " "
cd ./step-5-make-pathway
cp ../step-4-collect-structures/COORDS_IMAGE_* .
cp ../PDB_INFO .
NUMBER_OF_IMAGES=$(grep pathway ../step-4-collect-structures/number_of_structures_in_pathway)
NUMBER_OF_PARTICLES=$(grep NUM_PARTICLES ../step-4-collect-structures/INPUT_COLLECT_ENERGY)
./5_makepathway -n ${NUMBER_OF_PARTICLES: -4} -i ${NUMBER_OF_IMAGES: -3} -a 0
echo " "
echo "Step 5 is done"
echo " "

# Load results
vmd pathway.pdb
