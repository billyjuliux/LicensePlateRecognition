function ret = detectCharCNN(net, letterImg)
    % Labels for template images
    label = [
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ...
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'I', 'J', 'K', 'L', 'M', 'M', ...
        'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ...
    ];

    % Reformat the image as 3 channels
    rgbImage = cat(3, letterImg, letterImg, letterImg);

    % Resize img
    letterImg = imresize(rgbImage, [32 32]);

    % Predict the letter
    % net = importKerasNetwork('model.h5');
    prediction = predict(net, letterImg);
    [~, argmax] = max(prediction);
    
    ret = label(argmax);
end
