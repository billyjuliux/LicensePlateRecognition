function [listImg, listBB] = getSegmentedChar(segment, imgSize)
    %getSegmentedChar - Get segmented character from segmented image

    listImg = {};
    listBB = {};

    % Get Image height
    h = imgSize(1);

    % for each segment, get the bounding box and the char image
    for i = 1:length(segment)
        seg = segment(i);

        [y, x] = size(seg.Image);

        % Filter out segment that doesn't fit the criteria
        % Segment should be less than 80% of original image height, more than 20% of original image height
        % and the length should be less than the height
        if y < (0.8 * h) && y > (0.2 * h) && x <= y

            img = seg.Image;
            bb = seg.BoundingBox;
            listImg{end + 1} = img;
            listBB{end + 1} = bb;
        end

    end

end
