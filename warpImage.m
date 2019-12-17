
function [warpIm, mergeIm] = warpImage(inputIm, refIm, H)

    [input_height, input_width, ~] = size(inputIm); 
    [ref_height,ref_width,~] = size(refIm);

    my_matrix = ones(3,4);
    [~, matrix_width] = size(my_matrix); % width of matrix
     
    my_matrix(1,3:4) = [input_width, input_width];
    my_matrix(2,2:4) = [input_height, 1, input_height];
    
    normalized_matrix = zeros(size(my_matrix));

    warped_matrix = H * my_matrix;
    
    for i = 1 : matrix_width
        normalized_matrix(:,i) = (1/warped_matrix(3,i)) * warped_matrix(:,i);
    end
    
    inverse_H = H ^ (-1);
    
    width_min = min(normalized_matrix(1,:));
    len_min = min(normalized_matrix(2,:));
    width_max = max(normalized_matrix(1,:));
    len_max = max(normalized_matrix(2,:));
    
    [width_range,len_range] = meshgrid(width_min : width_max,len_min : len_max);
    
    width = round( (width_max - width_min) + 0.5 ); % next whole number 
    height = round( (len_max - len_min) + 0.5 ); % next whole number
   
    area = height * width; 
    
    [width_range_x, width_range_y, ~] = size(width_range); 
    width_range_num_elements = width_range_x * width_range_y;
    
    points_matrix(1,:) = width_range(:)';
    points_matrix(2,:) = len_range(:)'; 
    points_matrix(3,:) = ones(1,width_range_num_elements)'; 
    
    pointsSource = inverse_H * points_matrix;
    
    nPoints = size(pointsSource,2);
    normalizedPoints = magic(size(pointsSource));
    
    for i = 1:nPoints
        normalizedPoints(:,i) = pointsSource(:,i)/pointsSource(3,i);
    end
    
    pointsSource = normalizedPoints;
    
    warped_matrix_width = size(pointsSource,2);
    
    for i = 1:warped_matrix_width
        normalized_matrix(:,i) = pointsSource(:,i) / pointsSource(3,i);
    end

    pointsSource = normalized_matrix;
    
    point_source_x = round(pointsSource(1,:));
    point_source_y = round(pointsSource(2,:));

    pointsSource(3,:,:) = [];

    truth_matrix = (point_source_x < input_width) & (point_source_y < input_height) & (point_source_x >= 1) & (point_source_y >= 1);
    
    warpIm = zeros(area, 3, 'uint8');
    
    for i = 1:width*height
        if(truth_matrix(i) == 1) 
            warpIm(i,:) = inputIm(point_source_y(i), point_source_x(i), :);
        end
    end

    warpIm = reshape(warpIm,height,width,3);
    [tempx,tempy] = size(inverse_H);
    if(len_min < 0)
        new_y = round(abs(len_min));
    else
        new_y = tempy;
    end

    if(width_min < 0)
        new_x = round(abs(width_min));
    else
        new_x = tempx;
    end
     
    tm = ones(ref_height + (new_y - 1), ref_width + (new_x - 1), 3, 'uint8');
    
    tm(new_y:end, new_x:end, :) = refIm;
    mergeIm = imfuse(warpIm, tm, 'blend');
    
end
