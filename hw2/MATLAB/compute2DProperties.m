function [db, out_img] = compute2DProperties(orig_img, labeled_img)
    num_obj = max(labeled_img(:));
    [row,col] = size(orig_img);
    db = zeros(6,num_obj);
    class = {'1','2','3','4','5','6'};
    % compute the center pointer for each object
    out_img = orig_img;
    figure;
    imshow(orig_img);
    hold on;
    for i =1:1:num_obj
        db(1,i) = i;
        mask = zeros(row,col);
        mask(find(labeled_img == i)) = 1;
        x = ones(row,1)*[1:col];
        y = [1:row]'*ones(1,col);   
        area = sum(sum(mask)); 
        meanx = sum(sum(mask.*x))/area; 
        meany = sum(sum(mask.*y))/area;
        db(2,i) = meanx;
        db(3,i) = meany;
        
        % compute a, b and c
        a =sum(sum(mask.* (x-meanx).^2));
        c =sum(sum(mask.* (y-meany).^2));
        b =2.*sum(sum(mask.*(x-meanx).*(y-meany)));
        
        %find the oritation
        theta = 0.5*atan2(b,a-c);
       
        
        % find the minimum moment of inertia and roundness
        minimum = 0.5*(a+c - sqrt((a-c)^2 + b^2));
        maximum = 0.5*(a+c + sqrt((a-c)^2 + b^2));
        roundness = minimum/maximum;
        db(4,i) = minimum;
        db(6,i) = roundness;
      
        
        % draw the center and the oritation
        plot(db(2,i),db(3,i),'r+');
        %text(db(2,i),db(3,i),class{i});
        hold on;
        %drow the oritaiton line
        slope = tan(theta);
        xx = (-20:20)+meanx;
        yy = slope*(xx-meanx) + meany;
        plot(xx,yy);
        hold on;
        % due to the different representation of axies in matlab
        theta = -theta/pi*180;
        db(5,i) =theta;
        
    end
    
    out_img=rgb2gray(imresize(print('-RGBImage'),size(orig_img)));
    %close all;
    