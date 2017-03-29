%Open the first image and take 8 points
orig = imread('orig.jpg');
imshow(orig);
[X,Y] = ginput(8);
x1 = [X,Y];

%Open the second image and take 8 points
tr = imread('tr.jpg');
imshow(tr)
[X,Y] = ginput(8);
x2 = [X,Y];

%%
%Make the x1 and x2 Homogeneous
homo_x2 = [x2, ones(8,1,'double')];
homo_x1 = [x1, ones(8,1,'double')];

%%
%Compute the F matrix
[F,inliers] = estimateFundamentalMatrix(x1,x2,'Method','Norm8Point');

%%
%Display the second image
imshow(tr);
hold on;

%Plot the taken points on the image
plot(x2(inliers,1),x2(inliers,2),'go')

%Find the epipolar lines
epiLines1 = [F * homo_x1']';
points = lineToBorderPoints(epiLines1,size(tr));

%Plot the epipolar lines on the image
line(points(:,[1,3])',points(:,[2,4])');
truesize;

%Find the epipole using the formula
[D1,E1] =eigs(F*F');
e1calculated = D1(:,1)./D1(3,1);

%%
%I found that the epipole lies in the image itself, hence I obeserved the values from the image. 
e1observed  = ginput(1);
e1observed = [e1observed 1]';

%Find the difference in observed and calculated epipoles
error1 = e1calculated - e1observed;

%%
%Display the first image
imshow(orig);
hold on;

%Plot the taken points on the image
plot(x1(inliers,1),x1(inliers,2),'go')

%Plot the
epiLines2 = homo_x2 * F;
points = lineToBorderPoints(epiLines2,size(tr));

%Plot the epipolar lines on the image
line(points(:,[1,3])',points(:,[2,4])');
truesize;

%Find the epipole using the formula
[D2,E2] =eig(F'*F);
e2calculated = D2(:,1)./D2(3,1);

%%
%I found that the epipole lies in the image itself, hence I obeserved the values from the image. 
e2observed  = ginput(1);
e2observed = [e2observed 1]';

%Find the difference in observed and calculated epipoles
error2 = e2calculated - e2observed;