
function H = computeH(t1, t2) 
    [~, y, ~] = size(t1);
    
    num_cols = y; % number of cols 
    
    extra_ones_row = ones(1, num_cols); 
    
    zero_matrix_len = num_cols * 2;
    zero_matrix_width = 3 * 3; % because 3 x 3 matrix 

    t1 = [t1 ; extra_ones_row]; 
    t2 = [t2 ; extra_ones_row];
    
    M = zeros(zero_matrix_len, zero_matrix_width); % new matrix  

    for n = 1 : num_cols
        M((2*n)-1 : 2*n, :) = [t1(:,n)', 0 0 0 , t1(:,n)' * -(t2(1,n)) 
                 0 0 0 , t1(:,n)', t1(:,n)' * -(t2(2,n))];
    end
    
    [a, b] = eig(M' * M);
    
    [~, loc] = min(diag(b));

    H = reshape(a(:,loc),3,3)';
    
end

