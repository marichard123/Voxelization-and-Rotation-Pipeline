MyFileInfo=dir('Thingiverse_Tools_Folder');
[x, y] = size(MyFileInfo);
for i =3:x
    named = MyFileInfo(i).name;
    %disp(strcat('./Thingiverse_Tools_Folder/',named))
    read_rotate_save_stl(strcat('./Thingiverse_Tools_Folder/',named));
    disp(named)
end

% Voxelizing code (probably not going to use because doesn't include scale
% factor and also messy to move from MATLAB to Python
% OUTPUTgrid = zeros(x,64,64,64);
% for i =3:x
%     OUTPUTgrid(i,:,:,:) = VOXELISE(64,64,64,strcat('./3D_Printing_Most_Makes_Original_Orientation/',MyFileInfo(i).name),'xyz');
% end
% 
% OUTPUTgrid(70,:,:,:)