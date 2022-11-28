function [letters, bbImg] = detectCharFromPlate(img)
    img = rgb2gray(img);
    ret = segmentPlate(img);
    [chars, bb] = getSegmentedChar(ret, size(img));

    letters = [];

    bbImg = img;

    for i = 1:length(chars)
        letters = [letters, detectChar(chars{i})];

        BB = bb{i};

        bbImg = insertShape(bbImg, 'Rectangle', [BB(1), BB(2), BB(3), BB(4)], LineWidth = 2);
    end

end
