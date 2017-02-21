function output_img = recognizeObjects(orig_img, labeled_img, obj_db)
    num_obj = max(labeled_img(:));
    num_samples = size(obj_db,2);
    [row,col] = size(orig_img);
    % we can adjust the threshold to get better performance
    threshold = 0.2;
    [test_db,test_out] = compute2DProperties(orig_img,labeled_img);
    figure;
    imshow(orig_img);
    hold on;
    for i = 1:num_obj
        properties = test_db(:,i)*ones(1,num_samples);
        diff = abs(properties([4,6],:) - obj_db([4,6],:));
        %tmp = sum(diff,2)*ones(1,num_obj);
        diff = min((diff./obj_db([4,6],:))');
        display(diff);
        if(diff(1) < 0.15 && diff(2) < 0.1)
            
            % drao the center and the pivot;
            instance = test_db(:,i);
            meanx = instance(2);
            meany = instance(3);
            theta = instance(5);
            slope = tan(-theta/180*pi);
            plot(meanx,meany,'r+');
            xx = [-30:30]+meanx;
            yy = slope*(xx - meanx)+meany;
            plot(xx,yy);
            hold on;
        end
    end
    output_img=rgb2gray(imresize(print('-RGBImage'),size(orig_img)));
   
        
    