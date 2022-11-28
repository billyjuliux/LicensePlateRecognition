img = imread("img/plate/test.png");

plate = findPlate(img);

figure, imshow(plate);