function read_rotate_save_stl(fileName)
    [v, f, n, name] = stlRead(fileName);
    %[v, f, n, name] = stlread(fileName);
    %change file name as needed. must be in the same file location as this .m
    %file
    vi=[0 1 0];
    %vi is the new build direction you want (defined using the original file's
    %coordinate axes x, y, and z
    
    %then we rotate the vertices
    if all(vi==[0 0 1]) || all(vi==(-1*[0 0 1]))
        verts_r=verts;
    else
        k1=[0 0 1];
        v_1 = cross(vi,k1); 
        ssc = [0 -v_1(3) v_1(2); v_1(3) 0 -v_1(1); -v_1(2) v_1(1) 0]; 
        R = eye(3) + ssc + ssc^2*(1-dot(vi,k1))/(norm(v_1))^2;
        verts_r=R*[v(:,1)';v(:,2)';v(:,3)'];
    end
    fileName1 = strcat(fileName,'010.stl');
    
    %and output the file, changing the name as necessary
    stlWrite(fileName1,f,verts_r');
    %stlwrite(fileName1,f,verts_r');
    % second rotations
    vi=[0 -1 0];
    %vi is the new build direction you want (defined using the original file's
    %coordinate axes x, y, and z
    
    %then we rotate the vertices
    if all(vi==[0 0 1]) || all(vi==(-1*[0 0 1]))
        verts_r=verts;
    else
        k1=[0 0 1];
        v_1 = cross(vi,k1); 
        ssc = [0 -v_1(3) v_1(2); v_1(3) 0 -v_1(1); -v_1(2) v_1(1) 0]; 
        R = eye(3) + ssc + ssc^2*(1-dot(vi,k1))/(norm(v_1))^2;
        verts_r=R*[v(:,1)';v(:,2)';v(:,3)'];
    end
    fileName2 = strcat(fileName,'0-10.stl');
    
    %and output the file, changing the name as necessary
    stlWrite(fileName2,f,verts_r');
    
    % third orientation
    vi=[1 0 0];
    %vi is the new build direction you want (defined using the original file's
    %coordinate axes x, y, and z
    
    %then we rotate the vertices
    if all(vi==[0 0 1]) || all(vi==(-1*[0 0 1]))
        verts_r=verts;
    else
        k1=[0 0 1];
        v_1 = cross(vi,k1); 
        ssc = [0 -v_1(3) v_1(2); v_1(3) 0 -v_1(1); -v_1(2) v_1(1) 0]; 
        R = eye(3) + ssc + ssc^2*(1-dot(vi,k1))/(norm(v_1))^2;
        verts_r=R*[v(:,1)';v(:,2)';v(:,3)'];
    end
    fileName3 = strcat(fileName,'100.stl');
    
    %and output the file, changing the name as necessary
    stlWrite(fileName3,f,verts_r');
    
    % fourth orientation
    vi=[-1 0 0];
    %vi is the new build direction you want (defined using the original file's
    %coordinate axes x, y, and z
    
    %then we rotate the vertices
    if all(vi==[0 0 1]) || all(vi==(-1*[0 0 1]))
        verts_r=verts;
    else
        k1=[0 0 1];
        v_1 = cross(vi,k1); 
        ssc = [0 -v_1(3) v_1(2); v_1(3) 0 -v_1(1); -v_1(2) v_1(1) 0]; 
        R = eye(3) + ssc + ssc^2*(1-dot(vi,k1))/(norm(v_1))^2;
        verts_r=R*[v(:,1)';v(:,2)';v(:,3)'];
    end
    fileName4 = strcat(fileName,'-100.stl');
    
    %and output the file, changing the name as necessary
    stlWrite(fileName4,f,verts_r');
    
    % Fifth orientation
    vi=[0 0 -1];
    %vi is the new build direction you want (defined using the original file's
    %coordinate axes x, y, and z
    
    %then we rotate the vertices
    if all(vi==[0 0 1]) || all(vi==(-1*[0 0 1]))
        %verts_r=verts;
        %verts_r=-[v(:,1)';v(:,2)';v(:,3)'];
        verts_r=[-v(:,1)';v(:,2)';-v(:,3)'];
    else
        k1=[0 0 1];
        v_1 = cross(vi,k1); 
        ssc = [0 -v_1(3) v_1(2); v_1(3) 0 -v_1(1); -v_1(2) v_1(1) 0]; 
        R = eye(3) + ssc + ssc^2*(1-dot(vi,k1))/(norm(v_1))^2;
        verts_r=R*[v(:,1)';v(:,2)';v(:,3)'];
    end
    fileName5 = strcat(fileName,'00-1.stl');
    
    %and output the file, changing the name as necessary
    stlWrite(fileName5,f,verts_r');
end