function plate = detectPlate(image)

    % Convert input image to grayscale
    grayImg = im2gray(image);

    % Apply histogram equalization
    grayImg = histeq(grayImg);

    % Apply edge detection using gradient operator
    edgeImg = edge(grayImg, 'sobel');

    % Apply line dilatation and gap filling
    se90 = strel('line', 3, 90);
    se0 = strel('line', 3, 0);

    dilatedImg = imdilate(edgeImg, [se90 se0]);
    filledimg = imfill(dilatedImg, 'holes');

    clearedBorder = imclearborder(filledimg, 4);

    % Erode mask
    se = strel('diamond', 3);
    mask = imerode(clearedBorder, se);
    mask = imerode(mask, se);

    figure, imshow(labeloverlay(image, mask));

    % Get plate region
    regions = regionprops(mask, 'BoundingBox', 'Area', 'Image');
    boundingBox = regions.BoundingBox;
    max = regions.Area;

    for i = 1:numel(regions)
       if regions(i).Area > max
           max = regions(i).Area;
           boundingBox = regions(i).BoundingBox;
       end
    end   
    
    plate = imcrop(image, boundingBox);
end