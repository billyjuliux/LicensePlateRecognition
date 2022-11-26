function ret = segmentPlate(plateImg)
    %SEGMENTPlate function to segment the plate image into letters/numbers
    %   plateImg: the image of the plate
    %   ret: the segmented plate letter/number images

    % apply thresholding using imbinarize
    binImg = imbinarize(plateImg);

    % apply morphological opening to remove noise
    se = strel('disk', 2);
    binImg = imopen(binImg, se);

    ret = binImg
end
