## disc_vol.py

# Function to remove a certain number of volumes from the beginning of an MRI run, if the
# user desires so. However, it is recommended to rather include all volumes during preprocessing
# and include the respectively computed confounds (e.g. through fmriprep or fmri ) during statistical analysis.

# dependencies:
# - python 3.*
# - nibabel

# It currently takes five input variables, all of them being mandatory:
# bids_dir --> the directory in which BIDS conform data is stored
# participant --> the participant which runs should be trimmed
# start --> the volume the runs should start with
# length --> the length of the runs as sanity check
# del_orig --> overwrite or move original files

# this scripty heavily "borrows" from nipype's trim functionality
# (https://nipype.readthedocs.io/en/0.12.0/interfaces/generated/nipype.interfaces.nipy.preprocess.html#trim)

# version 1, 02/2019 - Peer Herholz (herholz.peer@gmail.com)

## usage example

# python disc_vol.py --bids_dir --participant --start --length --del_orig
# e.g.:
# python disc_vol.py --bids_dir /Users/peerherholz/Desktop/bids --participant sub-01 --start 5 --length 360 --del_orig n


import nibabel as nb
from glob import glob
import os
from os.path import join as opj
import argparse
from shutil import copy

parser = argparse.ArgumentParser()
parser.add_argument('--bids_dir', help='The directory in which BIDS conform data is stored.', required=True)
parser.add_argument('--participant', help='The participant which runs should be trimmed.', required=True)
parser.add_argument('--start', help='The volume the runs should start with.', required=True)
parser.add_argument('--length', help='The length of the runs as sanity check.', required=True)
parser.add_argument('--del_orig', help='Overwrite or move original files.', choices=['y', 'n'], required=True)

args = parser.parse_args()

s = slice(int(args.start), int(args.length))

list_nii = glob(opj(args.bids_dir, args.participant, 'func', '*bold.nii.gz'))

length_niis = []

for nii in list_nii:
    nii_len = nb.load(nii)
    length_niis.append(nii_len.shape[3])

if (length_niis[1:] == length_niis[:-1]) == False:
    print('Length of runs is not identical, better check!')

else:

    print('Length of runs is identical!')

    for nii in list_nii:

        nii_old = nb.load(nii)

        if int(args.length) > nii_old.shape[3]:
            print('The indicated length does not match the length of the runs, better check!')
            break

        else:

            nii_new = nb.Nifti1Image(nii_old.get_data()[...,s], nii_old.affine, nii_old.header)

            if args.del_orig == 'y':
                nb.save(nii_new, nii)

            elif args.del_orig == 'n':
                output_path = opj(args.bids_dir, 'derivatives', 'disc_vol', args.participant)

            if os.path.isdir(output_path) == True:
                copy(nii, output_path)
                nb.save(nii_new, nii)
            else:
                os.makedirs(output_path)
                copy(nii, output_path)
                nb.save(nii_new, nii)
