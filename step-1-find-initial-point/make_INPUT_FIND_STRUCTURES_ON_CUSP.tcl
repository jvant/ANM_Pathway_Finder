#!tcl

set STATE1 [lindex $argv 0]
mol new $STATE1
set selCA [atomselect top "name CA"]
set num_CA [selCA num]

set "outfile" [open "INPUT_FIND_STRUCTURES_ON_CUSP" w]
puts $outfile "NUM_PARTICLES $num_CA"
puts $outfile "CUT_OFFS 15.0 15.0"
puts $outfile "FORCE_CONSTANTS 0.1 0.1"
puts $outfile "CUSP_TOLERANCE 1.0e-5"
puts $outfile "NUM_IMAGES_INTERPOLATE 100"

close $outfile
