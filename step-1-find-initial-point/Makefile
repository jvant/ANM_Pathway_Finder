# Make file for 'find_structures_on_cusp.c'

#Last updated November 07, 2012

#GSLINC = /usr/local/include
#GSLPATH = /usr/local/lib

CC = gcc
CFLAGS = -Wall -Wno-unused-result -O3
LDFLAGS = -lm



PROG = 1_locate_struct_on_cusp
HDRS = force_pot_simple_enm.h include_all.h md_ld_common_d_dimension_namd.h membership_and_locate_point_on_cusp.h read_configuration.h wrtie_configuration.h 
SRCS = find_structures_on_cusp.c force_pot_simple_enm.c membership_and_locate_point_on_cusp.c read_configuration.c wrtie_configuration.c


OBJS = $(SRCS:.c=.o) 


#Build the executable
$(PROG) : $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $(PROG)

force_pot_simple_enm.o : force_pot_simple_enm.h

membership_and_locate_point_on_cusp.o : membership_and_locate_point_on_cusp.h

read_configuration.o : read_configuration.h

wrtie_configuration.o : wrtie_configuration.h

find_structures_on_cusp.o : include_all.h



