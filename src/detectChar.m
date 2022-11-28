function ret = detectChar(letterImg)
    % load templates
    load templateFile;

    tempLabel = [
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'I', 'J', 'K', 'L', 'M', ...
                'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ...
                '1', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'
            ];
    labelCount = size(tempLabel, 2);
    y = 24;

    letterImg = imresize(letterImg, [42 y]);

    rec = [];

    for i = 1:labelCount
        temp = imbinarize(template(:, ((i - 1) * y) + 1:i * y));

        cor = corr2(temp, letterImg);

        rec = [rec cor];
    end

    idx = find(rec == max(rec));

    ret = tempLabel(idx);
end
