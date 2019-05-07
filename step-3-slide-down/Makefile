#Makefile 'slide_down_one_surface_v2.c'
#Last updated March 18, 2013

#GSLINC = /usr/local/include
#GSLPATH = /usr/local/lib

CC = gcc
CFLAGS = -Wall -Wno-unused-result -O3
LDFLAGS = -lm



PROG = 3_desc_one_surface_v2
HDRS = align_two_structures_Lei.h calc_rmsd.h force_pot_simple_enm.h include_all.h md_ld_common_d_dimension_namd.h read_configuration.h slide_down_v2.h wrtie_configuration.h
SRCS = slide_down_one_surface_v2.c align_two_structures_Lei.c calc_rmsd.c force_pot_simple_enm.c read_configuration.c slide_down_v2.c wrtie_configuration.c


OBJS = $(SRCS:.c=.o) 


#Build the executable
$(PROG) : $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $(PROG)

align_two_structures_Lei.o : align_two_structures_Lei.h

calc_rmsd.o : calc_rmsd.h

force_pot_simple_enm.o : force_pot_simple_enm.h

read_configuration.o : read_configuration.h

slide_down_v2.o : slide_down_v2.h

wrtie_configuration.o : wrtie_configuration.h

slide_down_one_surface_v2.o : include_all.h

