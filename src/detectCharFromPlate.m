function [letters, bbImg] = detectCharFromPlate(img, method, net)
    % Turn image into grayscale
    grayimg = im2gray(img);

    % Segment plate into characters and bounding boxes
    ret = segmentPlate(grayimg);
    [chars, bb] = getSegmentedChar(ret, size(grayimg));

    letters = [];

    bbImg = img;

    % For each character, do a template matching for char recognition
    for i = 1:length(chars)
        if (method == 'CNN')
            letters = [letters, detectCharCNN(net, chars{i})];
        else
            letters = [letters, detectChar(chars{i})];
        end

        % Draw bounding box on original image
        BB = bb{i};
        bbImg = insertShape(bbImg, 'Rectangle', [BB(1), BB(2), BB(3), BB(4)], LineWidth = 2, Color = 'green');
    end

end
