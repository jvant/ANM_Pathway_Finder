#!tcl

# Usage: vmd -dispdev text -eofexit < writepdbs_with_same_number_CA.tcl -args <pdb0_template> <pdb1_to_be_changed>

set pdb0 [lindex $argv 0]
set pdb1 [lindex $argv 1]

mol new $pdb0
mol new $pdb1

set sel0 [atomselect 0 "name CA"]
set sel1 [atomselect 1 "name CA"]

$sel0 writepdb CA0_tmp.pdb
$sel1 writepdb CA1_tmp.pdb

mol new CA0_tmp.pdb
mol new CA1_tmp.pdb

set chains [lsort -unique [$sel0 get chain]]

set sel1_newselecton {}
foreach chain $chains {
    set sel0_chain [atomselect 2 "chain $chain" ]
    set sel1_chain [atomselect 3 "chain $chain" ]
    puts "$pdb0 $chain has [$sel0_chain num] and $pdb1 $chain has [$sel1_chain num] "
    set sel0_resids [$sel0_chain get resid]
    if {[lindex $chains end] == $chain} {
	lappend sel1_newselecton "((chain $chain) and (resid $sel0_resids))"
    } else {
	lappend sel1_newselecton "((chain $chain) and (resid $sel0_resids)) or"
    }
}

puts "Done with iterations!"
#puts [join $sel1_newselecton]
set sel0_new [atomselect 2 "[join $sel1_newselecton]"]
set sel1_new [atomselect 3 "[join $sel1_newselecton]"]
if {[$sel1_new num] == [$sel0_new num]} {
    puts "Number of CAs match in both selections!"
    puts "Creating pdbs: CAs_$pdb1 CAs_$pdb1"
    $sel0_new writepdb CAs_$pdb0
    $sel1_new writepdb CAs_$pdb1
} else {
    puts "Number of CAs do not match in both selections!"
    puts "$pdb0 [$sel0_new num] and $pdb1 [$sel1_new num]"
    puts "Segnames are not the same!!!"
}
$sel0_new writepdb CAs_$pdb0
$sel1_new writepdb CAs_$pdb1


puts "Done!"
exit
