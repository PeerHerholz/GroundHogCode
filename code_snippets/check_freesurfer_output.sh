# This bash script loads data processed with freesurfer stored under data_path into freeview to check if everything went well
# data_path should be your subject directory along with the specific subject

data_path=$1
echo data_path is $data_path

freeview -v $data_path/mri/brainmask.mgz \
         -v $data_path/mri/aseg.mgz:colormap=lut:opacity=0.2 \
         -f $data_path/surf/lh.white:edgecolor=yellow \
         -f $data_path/surf/rh.white:edgecolor=yellow \
         -f $data_path/surf/lh.pial:annot=aparc:edgecolor=red \
         -f $data_path/surf/rh.pial:annot=aparc:edgecolor=red
