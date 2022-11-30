clear all; close all; clc;
directory_name = 'stl_repository';

%Copying files to another directory and creating rotated .STL files for
%reference
rotated_files_directory = 'rotated_files';
command = ['mkdir ', rotated_files_directory];
system(command);
command = ['copy ', directory_name, ' ', rotated_files_directory];
system(command);

dinfo = dir(rotated_files_directory);
stl_filenames = {dinfo.name};
for i = 3:length(stl_filenames)
    full_pathway = [rotated_files_directory, '\', stl_filenames{i}];
    if length(strfind(full_pathway,'.stl')) ==1 %prevents files from being repeatedly rotated
        read_rotate_save_stl(full_pathway)
    end
end

%Copying files to another directory and voxelizing/rotating them
voxelization_directory = 'Binvox_files_default_res';
command = ['mkdir ', voxelization_directory];
system(command);
command = ['copy ', directory_name, ' ', voxelization_directory];
system(command);

dinfo = dir(voxelization_directory);
stl_filenames = {dinfo.name};
%voxelizing the individual files
for i = 3:length(stl_filenames)
    full_pathway = [voxelization_directory, '\', stl_filenames{i}];
    command = ['binvox ',full_pathway];
    system(command)
    command = ['del ' full_pathway];
    system(command)
end
%rotating the individual files
dinfo = dir(voxelization_directory);
binvox_filenames = {dinfo.name};
for i = 3:length(binvox_filenames)
    full_pathway = [voxelization_directory, '\', binvox_filenames{i}];
    command = ['python read_rotate_save_binvox.py ', full_pathway];
    system(command)
    disp(command);
end


%%Copying files to another directory and voxelizing /rotating them, 64
%%resolution
%voxelization_directory = 'Binvox_files_64_res';
%command = ['mkdir ', voxelization_directory];
%system(command);
%command = ['copy ', directory_name, ' ', voxelization_directory];
%system(command);
%
%dinfo = dir(voxelization_directory);
%stl_filenames = {dinfo.name};
%%voxelizing the individual files
%for i = 3:length(stl_filenames)
%    full_pathway = [voxelization_directory, '\', stl_filenames{i}];
%    command = ['binvox -d 64 ',full_pathway];
%    system(command)
%    command = ['del ' full_pathway];
%    system(command)
%end
%%rotating the individual files
%dinfo = dir(voxelization_directory);
%binvox_filenames = {dinfo.name};
%for i = 3:length(binvox_filenames)
%    %disp(binvox_filenames{i})
%    full_pathway = [voxelization_directory, '\', binvox_filenames{i}];
%    %disp(full_pathway)
%    %command = 'python read_rotate_save_binvox.py test_directory/chair.binvox';
%    command = ['python read_rotate_save_binvox.py ', full_pathway, ' readjust'];
%    system(command)
%    disp(command);
%end
