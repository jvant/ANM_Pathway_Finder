#!tcl

set sel [atomselect top "chain A"]
$sel set segid K
set sel [atomselect top "chain B"]
$sel set segid C
set sel [atomselect top "chain C"]
$sel set segid B
set sel [atomselect top "chain D"]
$sel set segid E
set sel [atomselect top "chain E"]
$sel set segid D
set sel [atomselect top "chain F"]
$sel set segid A
set sel [atomselect top "chain G"]
$sel set segid F
set sel [atomselect top "chain H"]
$sel set segid Z
set sel [atomselect top "chain I"]
$sel set segid G
set sel [atomselect top "chain J"]
$sel set segid X
set sel [atomselect top "chain K"]
$sel set segid Y
set sel [atomselect top "chain X"]
$sel set segid I
set sel [atomselect top "chain Y"]
$sel set segid J
set sel [atomselect top "chain Z"]
$sel set segid H

foreach seg { A B C D E F G H I J K L M N O P Q R S T U V W X Y Z } {
    set sel [atomselect top "segid $seg"]
    $sel set chain $seg
}
set selall [atomselect top all]

$selall writepdb 6fkh-name-change.pdb
