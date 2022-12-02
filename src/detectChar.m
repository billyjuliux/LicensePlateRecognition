function ret = detectChar(letterImg)
    % Load template images
    load templateFile;

    % Labels for template images
    label = [
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'I', 'J', 'K', 'L', 'M', 'M', ...
            'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ...
            '1', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '0'
        ];
    labelCount = size(label, 2);

    % Image height
    y = 24;

    % Resize img to fit template
    letterImg = imresize(letterImg, [42 y]);

    listcorr = [];

    for i = 1:labelCount
        % Get template and binarize
        temp = imbinarize(template(:, ((i - 1) * y) + 1:i * y));

        % Get correlation
        corr = corr2(temp, letterImg);

        % Add correlation to list
        listcorr = [listcorr corr];
    end

    % Get max correlation
    idx = find(listcorr == max(listcorr));

    % Get label for letter
    ret = label(idx);
end
