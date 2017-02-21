function labeled_img = generateLabeledImage(gray_img, threshold)
    k = 2;
    
    bw_img = im2bw(gray_img,threshold);
    %dilation
    processed_img = bwmorph(bw_img, 'dilate', k);
    %erotion
    processed_img = bwmorph(processed_img, 'erode', k);
    labeled_img = bwlabel(processed_img,8);
    