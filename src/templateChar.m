% Script file for loading templates

% Directory
templateDir = '../img/charTemplate';

% All the template chars
% Some chars have multiple versions to account for different fonts
A = imread(fullfile(templateDir, 'A.bmp'));
B = imread(fullfile(templateDir, 'B.bmp'));
C = imread(fullfile(templateDir, 'C.bmp'));
D = imread(fullfile(templateDir, 'D.bmp'));
E = imread(fullfile(templateDir, 'E.bmp'));
F = imread(fullfile(templateDir, 'F.bmp'));
G = imread(fullfile(templateDir, 'G.bmp'));
H = imread(fullfile(templateDir, 'H.bmp'));
I = imread(fullfile(templateDir, 'I.bmp'));
I2 = imread(fullfile(templateDir, 'I_2.bmp'));
J = imread(fullfile(templateDir, 'J.bmp'));
K = imread(fullfile(templateDir, 'K.bmp'));
L = imread(fullfile(templateDir, 'L.bmp'));
M = imread(fullfile(templateDir, 'M.bmp'));
M2 = imread(fullfile(templateDir, 'M_2.bmp'));
N = imread(fullfile(templateDir, 'N.bmp'));
O = imread(fullfile(templateDir, 'O.bmp'));
P = imread(fullfile(templateDir, 'P.bmp'));
Q = imread(fullfile(templateDir, 'Q.bmp'));
R = imread(fullfile(templateDir, 'R.bmp'));
S = imread(fullfile(templateDir, 'S.bmp'));
T = imread(fullfile(templateDir, 'T.bmp'));
U = imread(fullfile(templateDir, 'U.bmp'));
V = imread(fullfile(templateDir, 'V.bmp'));
W = imread(fullfile(templateDir, 'W.bmp'));
X = imread(fullfile(templateDir, 'X.bmp'));
Y = imread(fullfile(templateDir, 'Y.bmp'));
Z = imread(fullfile(templateDir, 'Z.bmp'));

one = imread(fullfile(templateDir, '1.bmp'));
one2 = imread(fullfile(templateDir, '1_2.bmp'));
two = imread(fullfile(templateDir, '2.bmp'));
three = imread(fullfile(templateDir, '3.bmp'));
four = imread(fullfile(templateDir, '4.bmp'));
five = imread(fullfile(templateDir, '5.bmp'));
six = imread(fullfile(templateDir, '6.bmp'));
seven = imread(fullfile(templateDir, '7.bmp'));
eight = imread(fullfile(templateDir, '8.bmp'));
nine = imread(fullfile(templateDir, '9.bmp'));
zero = imread(fullfile(templateDir, '0.bmp'));

letters = [A B C D E F G H I I2 J K L M M2 N O P Q R S T U V W X Y Z];

numbers = [one one2 two three four five six seven eight nine zero];

template = [letters numbers];

% Save template to a .mat file
save ('templateFile', 'template')

clear all
