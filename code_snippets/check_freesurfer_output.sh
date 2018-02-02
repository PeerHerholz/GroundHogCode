# check_freesurfer_output.sh

# This bash script loads data processed with freesurfer stored under data_path into freeview to do an initial check of some recon-all outputs 
# It currently takes one input variable, which is "data_path". This should be your subject directory along with the specific subject. 

# dependencies: - freesurfer

# version 1, 01/2018 - Malte Gueth (maltegueth@gmail.com)
#                    - Peer Herholz (herholz.peer@gmail.com)

# usage example

# bash check_freesurfer_output.sh /path/to/your/dataset/derivatives/freesurfer/sub-01/

# function input 
data_path=$1

# display data_path
echo "data_path is $data_path"

# check if data_path exists empty
if [ ! -d "$data_path/mri/" ]; then
  echo "the folder $data_path/mri doesn't exist, check again and make sure that your path is correct"
fi

if [ ! -d "$data_path/surf/" ]; then
  echo "the folder $data_path/surf doesn't exist, check again and make sure that your path is correct"
fi

# start freeview and load respective following outputs:
# load brainmask
# load aseg segmentation, overlay on brainmask
# load lh white surface, overlay in yellow 
# load rh white surface, overlay in yellow
# load lh pial surface, annotation=aparc, overlay in red
# load rh pial surface, annotation=aparc, overlay in red

freeview -v $data_path/mri/brainmask.mgz -v $data_path/mri/aseg.mgz:colormap=lut:opacity=0.2 -f $data_path/surf/lh.white:edgecolor=yellow -f $data_path/surf/rh.white:edgecolor=yellow -f $data_path/surf/lh.pial:annot=aparc:edgecolor=red -f $data_path/surf/rh.pial:annot=aparc:edgecolor=red 
