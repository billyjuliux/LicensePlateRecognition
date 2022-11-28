function [listImg, listBB] = getSegmentedChar(segment, imgSize)
    %getSegmentedChar - Get segmented character from segmented image
    listImg = {};
    listBB = {};

    h = imgSize(1);

    for i = 1:length(segment)
        [y, x] = size(segment(i).Image);

        if y < (0.8 * h) && y > (0.2 * h) && x <= y
            seg = segment(i);

            img = seg.Image;
            bb = seg.BoundingBox;
            listImg{end + 1} = img;
            listBB{end + 1} = bb;
        end

    end

end
