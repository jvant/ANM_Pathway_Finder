#!tcl

set STATE1 [lindex $argv 0]
mol new $STATE1
set selCA [atomselect top "name CA"]
set num_CA [$selCA num]

set "outfile" [open "INPUT_SLIDE_ONE_SURFACE" w]
puts $outfile "NUM_PARTICLES $num_CA"
puts $outfile "SURFACE_INDEX 1"
puts $outfile "CUT_OFF 15.0"
puts $outfile "FORCE_CONSTANT 0.1"
puts $outfile "STEP_SIZE 0.04"
puts $outfile "RMSD_PATHWAY 0.2"
puts $outfile "RMSD_DIFF_TOL 0.01"
puts $outfile "ENERGY_FROM_REFERENCE_TOL 0.0001"
puts $outfile "MAX_NUM_ITER 1000000"

close $outfile
