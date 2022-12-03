# -*- coding: utf-8 -*-
"""
Created on Tue Nov 15 05:32:49 2022

@author: Richard
"""

print("Reading, reducing and writing .binvox file. This program takes command-line filename arguments")
import sys
import os
#From command line, read in the filename and whether to readjust an incorrectly oriented image
#SYNTAX- THE 64 VERSION, THEN THE 256 VERSION
filename_1 = sys.argv[1]
filename_2 = sys.argv[2]
import binvox_rw_fastwrite2 as binvox_rw
import numpy as np
import copy
with open(filename_1, 'rb') as f:
    model_64 = binvox_rw.read_as_3d_array(f)
with open(filename_2, 'rb') as f:
    model_256 = binvox_rw.read_as_3d_array(f)
print("Voxelized model dimensions: " + str(model_64.dims))


voxel_grid_side_length =model_64.dims[0]
a = np.ones([voxel_grid_side_length,voxel_grid_side_length, voxel_grid_side_length], dtype=bool)
a = copy.deepcopy(~a)
    
true_placeholder = copy.deepcopy(~a[0,0,0])
true_indices = np.where(model_256.data==true_placeholder)
old_x_indices = true_indices[0]
old_y_indices = true_indices[1]
old_z_indices = true_indices[2]
    

#old_indices = np.array([old_x_indices,old_y_indices,old_z_indices])
real_x_indices = true_indices[0]
real_y_indices = true_indices[1]
real_z_indices = true_indices[2]

real_indices = np.stack((real_x_indices, real_y_indices, real_z_indices), axis = 1)

real_indices = np.divide(real_indices, 4)
#real_indices = np.round_(real_indices, decimals =0)
real_indices = np.floor(real_indices)
real_indices = real_indices.astype('int64')
real_indices = np.unique(real_indices, axis = 0)
print(real_indices)
print("   ")
#print(real_indices[:,0])
new_indices = np.array([real_indices[:,0],real_indices[:,1],real_indices[:,2] ])
print(new_indices)
    
a[[new_indices[0,:]], [new_indices[1,:]],[new_indices[2,:]]] = true_placeholder
print(a.shape)
#print(True in a)
model_64.data = copy.deepcopy(a)

#newfilename5 = filename[0:-7] + '.stl0-10.binvox'
#filename = 'Reduced_fastener.binvox'
filename = filename_2[0:-7] + '_compressed.binvox'
print('Writing')
with open (filename,'wb') as fp:
    model_64.write(fp)