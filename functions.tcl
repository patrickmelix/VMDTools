### Patrick Melix 2017/02/17
#
#
#Features:
#1)A simple way of creating supercells from a xyz-file or loaded molecule
#2)Inutitive xyz saving
#
#Source (vmd > source FILENAME) this file to use the functions.
#
#Usage:
#vmd > create_supercell_from_file FILENAME "ABC" X Y Z
#     FILENAME: xyz filename to load
#     ABC: Lattice Vectors as needed by pbc set, see documentation of PBCTools
#     X, Y, Z: Number of representations in each direction
#  e.g. create_supercell_from_file input.xyz "29.5 29.5 29.5" 2 2 1
#
#
#vmd > create_supercell MOLID "ABC" X Y Z
#     MOLID: molecule to load (mostly number 1)
#     ABC: Lattice Vectors as needed by pbc set, see documentation of PBCTools
#     X, Y, Z: Number of representations in each direction
#  e.g. create_supercell 1 "29.5 29.5 29.5" 2 2 1
#
#Result can be saved with save_xyz(MOLID, FILE) to an xyz file


proc create_supercell_from_file { fileIn abc x y z} {
   set mol [mol new $fileIn waitfor all]
   pbc set "$abc" -all
   set newmol [::TopoTools::replicatemol $mol $x $y $z]
}
proc create_supercell { molIn abc x y z} {
   pbc set "$abc" -all
   set newmol [::TopoTools::replicatemol $molIn $x $y $z]
}

proc save_xyz { molOut fileOut } {
   animate write xyz $fileOut $molOut
}

proc vmd_draw_arrow {mol start end} {
   # an arrow is made of a cylinder and a cone
   set middle [vecadd $start [vecscale 0.8 [vecsub $end $start]]]
   graphics $mol materials on
   graphics $mol material Opaque
   graphics $mol color orange
   graphics $mol cylinder $start $middle radius 0.15 resolution 20
   graphics $mol cone $middle $end radius 0.25 resolution 20
}
