/* Align all the strucutres in the pathway with a reference strucutre. Then
 * make a PDB trajectory file out of aligned strucutres. Input files for images
 * are overwritten. Alignment is optional, the option is specified by a 
 * command line argument.*/

/* Uses new alignment code that can handle alignment based on a subset of atoms.*/
/* Uses 'PDB_INFO' as an input file. This is more general version of the previous
 * implementation.*/

/* Last updated on July 11, 2012*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <time.h>

#include "include_all.h"

/* 
 * Input file for system infomation to be used for writing PDB trajectory file: 'PDB_INFO'
 * Input files for coordinates: 'COORDS_IMAGE_1', 'COORDS_IMAGE_2', etc.
 *
 * Command line inputs: 1) Number of atoms.
 *                      2) Number of images.
 * Number of files = Number of images.
 *
 * Input file for optional alignment: 'REFERENCE_FOR_ALIGNMENT' and 'SUBSET_FOR_ALIGNMENT'
 *
 * The output file is called 'pathway.pdb'
 * */

/* Usage: ./makepathway -n Num_atoms -i Num_images -a Flag_indicating_alignment
          Flag_indicating_alignment = 1 if alignemnt is needed in that case files 'REFERENCE_FOR_ALIGNMENT' 
                                        and 'SUBSET_FOR_ALIGNMENT' need to be present in the same folder.
                                    = 0 if alignment is not needed.
 * */

int main(int argc, char *argv[])
{
  char *error_message = "Usage: ./makepathway -n Num_atoms -i Num_images -a Flag_indicating_alignment\nFlag_indicating_alignment = 1 if alignemnt is needed, in that case files 'REFERENCE_FOR_ALIGNMENT'\n                              and 'SUBSET_FOR_ALIGNMENT' need to be present in the same folder.\n                          = 0 if alignment is not needed.\n";
  if(argc == 1)
    {
      printf("For help type: ./makepathway -h\n");
      exit(1);
    }
  if(strcmp(argv[1],"-h")==0)
    {
      //printf("The usage is: ./makepathway -n Num_atoms -i Num_images\n");
      printf("%s", error_message);
      exit(1);
    }
  if(argc != 7)
    {
      printf("Error!\n");
      //printf("The usage is: ./makepathway -n Num_atoms -i Num_images\n");
      printf("%s", error_message);
      exit(1);
    }
  if(strcmp(argv[1],"-n")!=0 || strcmp(argv[3],"-i")!=0 || strcmp(argv[5],"-a")!=0)
    {
      printf("Error!\n");
      //printf("The usage is: ./makepathway -n Num_atoms -i Num_images\n");
      printf("%s", error_message);
      exit(1);
    }

  int Num_images;
  int Num_atoms; 
  char Filename_PDB_traj[1000];
  int Num_atoms_in_subset;
  int *Indices_atoms_in_subset;
  FR_DAT fr_ref, fr;
  char Filename[1000];
  int im;
  int align_flag;

  Num_atoms = atoi(argv[2]);
  Num_images = atoi(argv[4]);
  align_flag = atoi(argv[6]);
  if(align_flag != 0 && align_flag != 1)
    {
      printf("Input error.\n -a should be followed by either 1 or 0.\n");
      exit(1);
    }

  fr_ref.natoms = Num_atoms;
  fr_ref.x = (rvec*)malloc(Num_atoms * sizeof(rvec));
  fr.natoms = Num_atoms;
  fr.x = (rvec*)malloc(Num_atoms * sizeof(rvec));

  /* Check if alignment is requested or not.*/
  if(align_flag == 1)
    {
      /* Read the reference structure*/
      sprintf(Filename, "REFERENCE_FOR_ALIGNMENT");
      Read_config_simple_3d(Num_atoms, &fr_ref, Filename);
      
      /* Read information for alignment*/
      Read_alloc_subset_for_alignment(Num_atoms, &Num_atoms_in_subset, &Indices_atoms_in_subset);
      
      /* Align all strucutres in the pathway*/
      for(im = 0 ; im < Num_images ; im++)
	{
	  /* Read image*/
	  sprintf(Filename, "COORDS_IMAGE_%d", (im+1));
	  Read_config_simple_3d(Num_atoms, &fr, Filename);
	  /* Align image*/
	  Align_two_strucutres_using_subset_lei(&fr_ref, Num_atoms_in_subset, Indices_atoms_in_subset, &fr);
	  /* Write image, overwrite the input file*/
	  Write_config_simple(&fr, Filename);
	}
    }
  
  /* Make PDB trajectory file from aligned images*/
  sprintf(Filename_PDB_traj, "pathway.pdb");
  Make_PDB_traj_from_images_v2(Num_images, Num_atoms, Filename_PDB_traj);
  
  return 0;
}


