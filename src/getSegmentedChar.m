function [listImg, listBB] = getSegmentedChar(segment)
    %getSegmentedChar - Get segmented character from segmented image
    listImg = {};
    listBB = {};

    for i = 1:length(segment)
        seg = segment(i);

        img = seg.Image;
        bb = seg.BoundingBox;
        listImg{i} = img;
        listBB{i} = bb;

    end

end
