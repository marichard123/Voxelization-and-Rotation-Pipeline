function read_rotate_random_save_stl(fileName)
[v, f, n, name] = stlRead(fileName);
vi=[0 1 0];
%vi=[-1 0 0];
psi = rand*360;
phi = rand*360;
theta = rand*360;
Q_psi = [cosd(psi) sind(psi) 0;
    -sind(psi), cosd(psi), 0;
    0 0 1];
Q_theta = [cosd(theta) 0 -sind(theta);
    0 1 0;
    sind(theta) 0 cosd(theta)];
Q_phi = [1 0 0;
    0 cosd(phi) sind(phi);
    0 -sind(phi) cosd(phi)];
vi = transpose(Q_phi* Q_theta*Q_psi * transpose(vi));
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
    %fileName1 = strcat(fileName,'LALALALAL_Random_raarotoattaion.stl');
    fileName1 = strcat(fileName,'_',int2str(floor(phi)),'_', int2str(floor(theta)), '_', int2str(floor(psi)),'.stl');
    stlWrite(fileName1,f,verts_r');
end