
I = imread('plug.jpg');
I2 = imread('plug2.jpg');

% ransac for homography works very similarly to line fitting. It picks
% points at random first, adds 

imshow(I);
a = ginput(2)';  %1x10 matrix

imshow(I2);
b = ginput(2)'; % 1x10 matrix

x = computeH(a, b);

p = 2; %
q = 20;
z = 4;

for i = 0 : q
  bp = [];
  input_points = [];
    
  [~, c, ~] = size(a);
  my_rand = randi(c, p, 1);
  
  for j = 1 : p
      x = my_rand(j,1);
      
      bp(:,j) = a(1:2, x);
      
      input_points(:,j) = a(1:2, x);
      
  end

  inliers = 0;
  total_error = 0;
   
  my_h = computeH(bp, bp);
  


  %For each point, find the error and if its less than t, make it an inlier 

  for j = 1 : c

    error = sum(sum((my_h.*[a(j,:)';1] - [b(j,:)';1]).*(my_h.*[a(j,:)';1] - [b(j,:)';1])));

    error
    
    inliers = inliers + 1;
    total_error = total_error + error;

  end

    final_model = my_h;
    final_error = total_error;

    final_error

end

    

