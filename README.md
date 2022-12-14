# Voxelization-and-Rotation-Pipeline
Files written during URAP Fall 2022 undergraduate research to write and manipulate .stl and .binvox files

This repository makes use of a modified version of [binvox-rw.py](https://github.com/dimatura/binvox-rw-py), written by Daniel Maturana. binvox-rw.py is distributed under the GNU General Public License version 3, and as such the same free licensing conditions apply to this repository. The files make heavy use of [binvox.exe](https://www.patrickmin.com/binvox), written by Patrick Min.


# What it does:
This pipeline will rotate STL files into 5 new orientations. Each new orientation is achieved by a linear combination of 90 degree rotations about the X and Y axes in 3D space, such that the image will be rotated to lie on one of six "faces", as the six faces of a die might be oriented.

From a single STL file, 6 STL files and 6 voxelized .binvox files will be produced. Rotated STL files are stored in newly created directory named 'rotated_files', while .binvox files are stored in directories named 'Binvox_files_64_res' or 'Binvox_files_default_res', depending on the chosen resolution.


# How to use it:
To download and make use of the pipeline, the entire Voxelization-and-Rotation-Pipeline repository should be downloaded as a zip file and unzipped. Once installed, there are only two steps to using the pipeline:

1). **The STL files to be voxelized and rotated should be moved inside a folder called 'stl_repository', which is to be located inside the Voxelization-and-Rotation-Pipeline directory.** A zipped 'stl_repository' folder is included, with several sample STL files inside of it. Once unzipped, the pipeline is ready to run, and STL files may be added to the 'stl_repository' folder as desired. Alternatively, a pathway to an alternative pipeline of a different name may be specified—the next step will describe this process.

2). **The 'voxelization_rotation_user_interface.m' MatLab file should be run. By default, the user will be prompted to confirm his or her decision to delete the rotated and voxelized files generated by previous runs. No further action or manipulation is required.** By default, the pipeline will read files from a folder called 'stl_repository' located in the same directory, and will delete the result of previous runs. These conditions may be changed in lines 3 and 2 of 'voxelization_rotation_user_interface.m', respetively. In line 4, the user may choose whether to voxelize to both default and 64^3 dimension (default_dimension_only = false;), or whether to voxelized to only deafult dimension (default_dimension_only = false;).

The results of the pipeline's calcaultions will be stored in the newly generated folders of 'Binvox_files_64_res', 'Binvox_files_default_res', and 'rotated_files'.


# How it works:
STL files are rotated using the 'read_rotate_save_stl.m' MatLab function, written by Sara Shonkwiler. In the current iteration, this function is only used to create rotated STL files for reference; these rotated STL files are not subsequently voxelized, as it was found that rotating .binvox files after voxelization greatly reduced runtime as voxelization was by far the slowest step.

To create the voxelized directories, files are first voxelized using binvox.exe, called by the MatLab scripts through console commands. The .binvox files are then rotated using the 'read_rotate_save_binvox' script, with files being read and written using 'binvox_rw_fastwrite2.py', the aforementioned modified version of 'binvox_rw.py'. After the reading functions are executed, voxelized files are represented as 3D boolean matrices, with 'true' values representing the locations of voxels in 3D space. Rotation is conducted by shifting matrix coordinates to establish a coordinate system with an origin at the center of the grid, and matrix multiplying with rotation matrices to rotate the points about the origin. The body is then translated until just comining into contact with the X, Y and Z axes.

Binvox files are run-length encoded binary files, with the first byte representing the boolean value of a point and the second byte representing the number of times that the first byte appears; Patrick Min has written a [detailed description](https://www.patrickmin.com/binvox/binvox.html) of the .binvox file format with more information. 

'binvox_rw_fastwrite2.py' is used to rapidly encode and write the voxel images by flattening the coordinates matrices and isolating points at which boolean values switch (i.e., the indices 'i' for which 'i+1' is a different value). Knowing the value of the first index and the indices at which values switch, binary values can be extrapolated and written potentially orders of magnitude faster that the unmodified 'binvox_rw.py' writing function, which simply loops over every grid value.

When 64^3 dimension voxelizations are desired, default (256^3) dimension voxelizations are compressed down to 64^3 dimension. To achieve this, full-dimension coordinates are simply divided by four and rounded down to the nearest integer to yield 64^3 dimension coordinates. Rounding down was chosen to avoid exceeding array bounds when rounding to the nearest integer.

Finally, after all files have been voxelized and rotated, STL files that failed to voxelize, and STL files/.binvox files that resulted in empty voxelizations are automatically removed from the dataset and moved to the 'failed_voxelizations' and 'empty_binvox_files' directories, which will be created for this purpose. Failed STL files can be identified by their lack of corresponding .binvox files in the dataset; empty binvox files can be identified by their lack of rotated counterparts, due to their causing zero-dimension errors when matrix multiplying.
