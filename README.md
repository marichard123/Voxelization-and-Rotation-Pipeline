# Voxelization-and-Rotation-Pipeline
Files written during URAP Fall 2022 undergraduate research to write and manipulate .stl and .binvox files

This repository makes use of a modified version of [binvox-rw.py](https://github.com/dimatura/binvox-rw-py), written by Daniel Maturana. binvox-rw.py is distributed under the GNU General Public License version 3, and as such the same free licensing conditions apply to this repository. The files make heavy use of [binvox.exe](https://www.patrickmin.com/binvox), written by Patrick Min.

From the end user's perspective, this repository should be downloaded entirely and its files run inside its directory. There are only three steps to using the pipeline:

1). The STL files to be voxelized and rotated should be moved inside the 'stl_repository' folder.

2). One of the MatLab voxelization and rotation files should be run ('voxelize_and_rotate.m', 'voxelize_and_rotate_7_64.m'). If the desired STL files are correctly located inside a folder named 'stl_repository' within the same directory as these MatLab files, then no further user input is required besides running the file. Pipeline output will vary based on the selected file. 'voxelize_and_rotate.m' will rotate STL files into 5 additional orientations and voxelize to default (264^3) dimension. 'voxelize_and_rotate_7_64.m' will rotate STL files into 6 additional orientations and voxelize to both default (264^3) and 64^3 dimension.

3). The MatLab file 'flagging_empty_and_failed_voxelizations.m' should be run—no further user input is required besides simply executing the file. Failed files (empty and failed voxelizations) will be moved out of the main dataset to their respective storage folders.
