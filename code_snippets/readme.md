### code snippets

The actual GroundHogCode snippets are stored here.

| script                        | function           | prerequisites  |
| ----------------------------- |:-------------:| :-----:|
| [BIDS_fslreorient_pydeface.sh](https://github.com/PeerHerholz/GroundHogCode/blob/GroundHogCode_peerherholz/code_snippets/BIDS_fslreorient_pydeface.sh)  | apply [fslreorient2std](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Orientation%20Explained), followed by [pydeface](https://github.com/poldracklab/pydeface) to every structural image in a BIDS formatted data set | data set in [BIDS format](http://bids.neuroimaging.io), [python2.something](https://www.python.org/downloads/release/python-2714/), [fsl](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki), [pydeface](https://github.com/poldracklab/pydeface), [nipype](http://nipype.readthedocs.io/en/latest/), [nibabel](http://nipy.org/nibabel/)  |
| [check_freesurfer_output.sh](https://github.com/PeerHerholz/GroundHogCode/blob/GroundHogCode_peerherholz/code_snippets/check_freesurfer_output.sh)      | visualize some important outputs of [FreeSurfer's](https://surfer.nmr.mgh.harvard.edu) [recon-all](https://surfer.nmr.mgh.harvard.edu/fswiki/recon-all) for a brief check|   (FreeSurfer)[https://surfer.nmr.mgh.harvard.edu] |
