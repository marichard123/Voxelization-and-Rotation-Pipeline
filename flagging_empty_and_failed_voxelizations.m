clear all; close all; clc;
%ONLY USE AS IF ALL RESOLUTIONS HAVE THE SAME NUMBER OF FILES AMONG THEM
rotated_files_directory_name = 'rotated_files';
voxelized_files_directory_name = 'Binvox_files_default_res';
failed_stl_files_directory_name = 'failed_voxelizations';
empty_binvox_files_directory_name = 'empty_binvox_files';


voxelized_files_directory = voxelized_files_directory_name;
dinfo = dir(voxelized_files_directory);
binvox_filenames = {dinfo.name};
for i = 3:(length(binvox_filenames)-1)
    if length(strfind(binvox_filenames{i},'.stl')) ==0 %checks to see if this is an original stl to binvox
        chopped_filename = binvox_filenames{i};
        chopped_filename = chopped_filename(1:end-7);
        %disp(chopped_filename)
        if length(strfind(binvox_filenames{i+1},chopped_filename)) ==0 %if the next file is not a rotation of this file
            command = ['move ' ,voxelized_files_directory,'\',binvox_filenames{i} ' ', empty_binvox_files_directory_name];
            disp(command)
            system(command);
        end
        
    end
end

rotated_files_directory = rotated_files_directory_name;
dinfo = dir(rotated_files_directory);
stl_filenames = {dinfo.name};
for i = 3:length(stl_filenames)
    chopped_filename = stl_filenames{i};
    chopped_filename = chopped_filename(1:end-4);
    stl_filenames{i} = chopped_filename;
end

voxelized_files_directory = voxelized_files_directory_name;
dinfo = dir(voxelized_files_directory);
binvox_filenames = {dinfo.name};
for i = 3:length(binvox_filenames)
    chopped_filename = binvox_filenames{i};
    chopped_filename = chopped_filename(1:end-7);
    binvox_filenames{i}=chopped_filename;
end

for i = 3:length(stl_filenames)
    if ~ismember(stl_filenames{i}, binvox_filenames)
        %command = ['move ' ,rotated_files_directory,'\',named, ' ', binvox_directory];
        command = ['move ' ,rotated_files_directory,'\',stl_filenames{i},'.stl' ' ', failed_stl_files_directory_name];
        system(command);
    end
end