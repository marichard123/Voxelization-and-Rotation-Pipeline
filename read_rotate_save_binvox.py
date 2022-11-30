# -*- coding: utf-8 -*-
"""
Created on Sat Oct  8 14:18:09 2022

@author: Richard
"""
print("Reading, rotating and writing .binvox file. This program takes command-line filename arguments")
import sys
import os
#From command line, read in the filename and whether to readjust an incorrectly oriented image
filename = sys.argv[1]
readjust = False
if len(sys.argv) > 2:
    if sys.argv[2]== 'readjust':
        readjust = True
import binvox_rw_fastwrite2 as binvox_rw
import numpy as np
import copy
with open(filename, 'rb') as f:
    model = binvox_rw.read_as_3d_array(f)
print("Voxelized model dimensions: " + str(model.dims))
def rotate_90(model, rotation_matrix):
    if (model.dims[0] % 2) != 0:        
        raise ValueError('ODD DIMENSIONS: GO BACK AND FIX THIS')
    voxel_grid_side_length =model.dims[0]
    a = np.ones([voxel_grid_side_length,voxel_grid_side_length, voxel_grid_side_length], dtype=bool)
    a = copy.deepcopy(~a)
    
    true_placeholder = copy.deepcopy(~a[0,0,0])
    true_indices = np.where(model.data==true_placeholder)
    old_x_indices = true_indices[0]
    old_y_indices = true_indices[1]
    old_z_indices = true_indices[2]
    
   
    old_indices = np.array([old_x_indices,old_y_indices,old_z_indices])
    centering_offset = np.full([3,len(old_x_indices)],int(model.dims[0]/2) )
    
    #establishing a new origin in the center of the old grid
    offset_old_indices = np.subtract(old_indices, centering_offset)
    
    offset_new_indices = np.matmul(rotation_matrix, offset_old_indices)
    #print(offset_new_indices)
    new_indices = np.add(offset_new_indices, centering_offset)
    #print(new_indices)
    x_shift_value = np.amin(new_indices[0,:])
    y_shift_value = np.amin(new_indices[1,:])
    z_shift_value = np.amin(new_indices[2,:])

    #shifting the image to the edge of the axes to ensure consistency and prevent cutoff
    new_indices[0,:] = np.subtract(new_indices[0,:], x_shift_value)
    new_indices[1,:] = np.subtract(new_indices[1,:], y_shift_value)
    new_indices[2,:] = np.subtract(new_indices[2,:], z_shift_value)
    
    
    a[[new_indices[0,:]], [new_indices[1,:]],[new_indices[2,:]]] = true_placeholder
    
    model.data = copy.deepcopy(a)
    return model



#The order of writing:

    
#No rotation


#Rotating on right side (with respect to no rotation)

ccw_x_rotation_matrix = np.array([[1,0,0],[0,0,-1],[0,1,0]])
cw_y_rotation_matrix = np.array([[0,0,1],[0,1,0],[-1,0,0]])

#readjusting and overriting the original file if necessary
if readjust:
    print('readjusting')
    print(filename)
    model = rotate_90(model, ccw_x_rotation_matrix)
    os.remove(filename)
    with open (filename,'wb') as fp:
        model.write(fp)




print('Rotating...')
model = rotate_90(model, cw_y_rotation_matrix)
newfilename1 = filename[0:-7] + '.stl-100.binvox'
print('Writing...')
with open (newfilename1,'wb') as fp:
    model.write(fp)


print('Rotating...')
#rotating on left side (by flipping the ride ride rotated image by 180 degrees)
model = rotate_90(model, np.matmul(cw_y_rotation_matrix,cw_y_rotation_matrix))
newfilename2 = filename[0:-7] + '.stl100.binvox'
print('Writing')
with open (newfilename2,'wb') as fp:
    model.write(fp)


#rotating on front face 
print('Rotating')
model = rotate_90(model, np.matmul(ccw_x_rotation_matrix,cw_y_rotation_matrix))
newfilename3 = filename[0:-7] + '.stl010.binvox'
print('Writing')
with open (newfilename3,'wb') as fp:
    model.write(fp)


#rotating upside down
print('Rotating')
model = rotate_90(model, ccw_x_rotation_matrix)
newfilename4 = filename[0:-7] + '.stl00-1.binvox'
print('Writing')
with open (newfilename4,'wb') as fp:
    model.write(fp)


print('Rotating')
#rotating  on back face
model = rotate_90(model, ccw_x_rotation_matrix)
newfilename5 = filename[0:-7] + '.stl0-10.binvox'
print('Writing')
with open (newfilename5,'wb') as fp:
    model.write(fp)



#ccw_x_rotation_matrix = np.array([[1,0,0],[0,0,-1],[0,1,0]])
#model.data = scipy.ndimage.interpolation.rotate(model.data, angle = 90)

#model = rotate_90(model, ccw_x_rotation_matrix)
#model = rotate_90(model, ccw_x_rotation_matrix)

#model.data = scipy.ndimage.interpolation.rotate(model.data, 90, axes = (1,0))
#print("Rotation calculated")

#model = rotate_90(model, x_rotation_matrix)
#print("Rotation calculated")


#model = rotate_90(model, x_rotation_matrix) 
#with open ('chair_2.binvox','wb') as fp:
#    model.write(fp)
    