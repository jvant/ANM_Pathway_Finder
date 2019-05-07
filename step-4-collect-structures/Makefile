#Makefile 'collect_calc_energy.c'
#Last updated December 21, 2012

#GSLINC = /usr/local/include
#GSLPATH = /usr/local/lib

CC = gcc
CFLAGS = -Wall -Wno-unused-result -O3
LDFLAGS = -lm



PROG = 4_collec_ener
HDRS = calc_energy_pathway.h calc_rmsd.h collect_structures.h force_pot_simple_enm.h include_all.h md_ld_common_d_dimension_namd.h read_configuration.h wrtie_configuration.h
SRCS = collect_calc_energy.c calc_energy_pathway.c calc_rmsd.c collect_structures.c force_pot_simple_enm.c read_configuration.c wrtie_configuration.c


OBJS = $(SRCS:.c=.o) 


#Build the executable
$(PROG) : $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $(PROG)

calc_energy_pathway.o : calc_energy_pathway.h

calc_rmsd.o : calc_rmsd.h

collect_structures.o : collect_structures.h

force_pot_simple_enm.o : force_pot_simple_enm.h

read_configuration.o : read_configuration.h

wrtie_configuration.o : wrtie_configuration.h

collect_calc_energy.o : include_all.h

