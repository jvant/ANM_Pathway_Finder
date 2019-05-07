#!tcl

set STATE1 [lindex $argv 0]
set STATE2 [lindex $argv 1]

set "outfile" [open "INPUT_INFO_STRUCTURES" w]
set firstline "$STATE1 $STATE2"
puts $outfile $firstline

mol new $STATE1
set sel [atomselect top all]
set chains [lsort -unique [$sel get chain]]
foreach name $chains {
    set selres [atomselect top "chain $name and name CA"]
    set numres [$selres num]
    puts $outfile "$name 1 to $numres"
}
close $outfile

