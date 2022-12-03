%clear all; close all; clc;
function voxelize_and_rotate_64_function(directory_name)
%directory_name = 'stl_repository';
%Copying files to another directory and creating rotated .STL files for
%reference
rotated_files_directory = 'rotated_files';
command = ['mkdir ', rotated_files_directory];
system(command);
command = ['copy ', directory_name, ' ', rotated_files_directory];
system(command);

dinfo = dir(rotated_files_directory);
stl_filenames = {dinfo.name};

%Copying files to another directory and voxelizing/rotating them
voxelization_directory = 'Binvox_files_default_res';
command = ['mkdir ', voxelization_directory];
system(command);
command = ['copy ', rotated_files_directory, ' ', voxelization_directory];
system(command);

voxelization_directory = 'Binvox_files_64_res';
command = ['mkdir ', voxelization_directory];
system(command);
command = ['copy ', rotated_files_directory, ' ', voxelization_directory];
system(command);
%Finishing up rotating the reference stl files
for i = 3:length(stl_filenames)
    full_pathway = [rotated_files_directory, '\', stl_filenames{i}];
    if length(strfind(full_pathway,'.stl')) ==1 %prevents files from being repeatedly rotated
        read_rotate_save_stl(full_pathway)
        %read_rotate_random_save_stl(full_pathway)
    end
end




voxelization_directory = 'Binvox_files_default_res';
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
    if length(strfind(full_pathway,'.stl')) ==0
        system(command);
    end
    %system(command)
    disp(command);
end


%Voxelizing to 64 dimension
voxelization_directory = 'Binvox_files_64_res';
dinfo = dir(voxelization_directory);
binvox_filenames = {dinfo.name};
%voxelizing the individual files
for i = 3:length(binvox_filenames)
    full_pathway = [voxelization_directory, '\', binvox_filenames{i}];
    split_string = split(full_pathway, '\');
    foreign_directory_pathway = ['Binvox_files_default_res', '\', split_string{2}];
    foreign_directory_pathway = [foreign_directory_pathway(1:end-4), '.binvox'];
    command = ['copy ', foreign_directory_pathway, ' ', voxelization_directory];
    system(command)
    
    %command = ['binvox ',full_pathway];
    %system(command)
    command = ['binvox -d 64 ',full_pathway];
    system(command)
    command = ['del ' full_pathway];
    system(command)
    
    
    
    default_res_name = [full_pathway(1:end-4), '.binvox'];
    compressed_res_name = [full_pathway(1:end-4),'_1', '.binvox'];
    command = ['python default_to_sixty_four_dim.py ', compressed_res_name, ' ', default_res_name];
    system(command);
    command = ['del ' default_res_name];
    system(command)
    command = ['del ' compressed_res_name];
    system(command)
end
%rotating the individual files
dinfo = dir(voxelization_directory);
binvox_filenames = {dinfo.name};
for i = 3:length(binvox_filenames)
    full_pathway = [voxelization_directory, '\', binvox_filenames{i}];
    command = ['python read_rotate_save_binvox.py ', full_pathway];
    if length(strfind(full_pathway,'.stl')) ==0
        system(command);
    end
    %system(command)
    disp(command);
end

