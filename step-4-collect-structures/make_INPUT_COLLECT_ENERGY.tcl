#!tcl

set STATE1 [lindex $argv 0]
mol new $STATE1
set selCA [atomselect top "name CA"]
set num_CA [selCA num]

set "outfile" [open "INPUT_COLLECT_ENERGY" w]
puts $outfile "NUM_PARTICLES $num_CA"
puts $outfile "CUT_OFF 15.0"
puts $outfile "FORCE_CONSTANT 0.1"

close $outfile 
