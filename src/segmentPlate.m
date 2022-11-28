function ret = segmentPlate(plateImg)
    %SEGMENTPlate function to segment the plate image into letters/numbers
    %   plateImg: the image of the plate
    %   ret: the segmented plate letter/number images

    % apply thresholding using imbinarize
    binImg = imbinarize(plateImg);

    % Remove small objects
    cleanImg = bwareaopen(binImg, round(0.001 * numel(binImg)));

    if bwarea(cleanImg) < bwarea(~cleanImg)
        segments = regionprops(cleanImg, 'Image', 'BoundingBox');
    else

        segments = regionprops(~cleanImg, 'Image', 'BoundingBox');
    end

    ret = segments
end
