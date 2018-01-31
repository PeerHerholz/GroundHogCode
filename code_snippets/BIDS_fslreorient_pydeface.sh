## BIDS_fslreorient_pydeface.sh

# This bash script prepares anatomical data in BIDS format for subsequent processing by applying fslreorient2std, followed by pydeface. Hence, it assumes you data is in BIDS format. It's especially useful, if you rearranged data and don't have the chance to go back to the original dicoms and use e.g. heudiconv, etc. to convert your data. If you do have the original dicoms, you should convert them again using the mentioned tools (wrt e.g. metadata extraction) and adjust those scripts accordingly.

# dependencies: 
# - python 2.*
# - fsl
# - pydeface
# - nipype
# - nibabel
 
# It currently takes three input variables, one of them being mandatory:
# env --> not mandatory, the environment the script should run in (e.g. if you normally work in python 3.*, you should source a pythopn 2.*)
# data_path --> mandatory, the path to your dataset in BIDS format
# del_no_deface --> not mandatory, decide if you want to keep or delete the original, not defaced, image

# version 1, 01/2018 - Peer Herholz (herholz.peer@gmail.com)

## usage example

# bash BIDS_fslreorient_pydeface.sh env data_path del_no_deface
# e.g.:
# bash BIDS_fslreorient_pydeface.sh python2 /Users/peer/bids_dataset rm_no_deface


# if set, source python 2 environment 
env=$1
source activate $env 

# 2nd input is data_path
data_path=$2   

# 3rd input indicates if original image (without defacing) should be kept
del_no_deface=$3 

# cd into data directory
cd $data_path

# get the list of all participants within the data directory and it display it
participant_list=$(ls -d sub-*)
echo "the following participants will be included: $participant_list"

# loop through the whole participant list and apply fslreorient2std, pydeface and possibly remove the originale, not defaced, images
for participant in ${participant_list}
do
	
	# define input image and set image names for subsequent processing
        anat="$data_path/$participant/anat/$participant" # path to anatomical image
        extension="_T1w.nii.gz" # file extension of anatomical image
	nodeface_id="_nodeface" # id for image without defacing
	IMAGE_NODEFACE=$anat$nodeface_id$extension # set complete image name for original, not defaced, image
        IMAGE=$anat$extension # set complete name for processed, defaced, image

	mv $IMAGE $IMAGE_NODEFACE # rename original image
	
	echo "working on $participant" # indicate which participant is currenly being processed 

        fslreorient2std $IMAGE_NODEFACE # apply fslreorient2std on the original image

        pydeface.py $IMAGE_NODEFACE $IMAGE # apply pydeface on the original image, writing an output file named like the original image without the no_deface id 
        
	# if 3rd input is set and is "rm_no_deface" then the original, not defaced, image will be deleted
	if [ $del_no_deface == "rm_no_deface" ]; then
	    echo "original image (before defacing) will be deleted"
	    rm $IMAGE_NODEFACE
	else
	    echo "original image (before defacing) will be kept under the name $IMAGE_NODEFACE"
	fi

done

