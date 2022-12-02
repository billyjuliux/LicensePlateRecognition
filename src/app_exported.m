classdef app_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        CNNPlateNumberRecognitonPanel  matlab.ui.container.Panel
        CNNOutputLabel                 matlab.ui.control.Label
        ImageProcessingPlateNumberRecognitonPanel  matlab.ui.container.Panel
        ImageProcessingOutputLabel     matlab.ui.control.Label
        PlateROIDetectionPanel         matlab.ui.container.Panel
        GridLayout3_2                  matlab.ui.container.GridLayout
        PlateROIImage                  matlab.ui.control.Image
        InputImagePanel                matlab.ui.container.Panel
        GridLayout4                    matlab.ui.container.GridLayout
        BrowseButton                   matlab.ui.control.Button
        InputImage                     matlab.ui.control.Image
    end

    
    properties (Access = private)
        img
        net = importKerasNetwork('model.h5')
    end
    
    methods (Access = private)

        function main(app)
            if isempty(app.img)
                return
            end

            loadDlg = uiprogressdlg(app.UIFigure, 'Title', 'Loading', 'Message', 'Please wait...');
            drawnow
            
            % Detect Plate
            plateImg = detectPlate(app.img);
            % app.PlateROIImage.ImageSource(plateImg);

            % Recognize Plate Number with Image Processing
            % [letters_ip, bbImg_ip] = detectCharFromPlate(plateImg, "IP", app.net);
            [lettersIP, bbImgIP] = detectCharFromPlate(plateImg, "IP", app.net);
            app.ImageProcessingOutputLabel.Text = lettersIP;
 
            % Recognize Plate Number with CNN
            [lettersCNN, ~] = detectCharFromPlate(plateImg, "CNN", app.net);
            app.CNNOutputLabel.Text = lettersCNN;

            app.PlateROIImage.ImageSource = bbImgIP;

            close(loadDlg)
        end

    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: BrowseButton
        function BrowseInputImage(app, event)
            extensions = {'*.jpg;*.jpeg;*.tif;*.png;*.gif','All Image Files'};
            [filename, path] = uigetfile(extensions, 'Open file');

            if (isequal(filename, 0))
                return
            end

            image = imread(fullfile(path, filename));
            app.InputImage.ImageSource = image;
            
            app.img = image;
            app.main();
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 711 598];
            app.UIFigure.Name = 'MATLAB App';

            % Create InputImagePanel
            app.InputImagePanel = uipanel(app.UIFigure);
            app.InputImagePanel.Title = 'Input Image';
            app.InputImagePanel.Position = [2 151 341 448];

            % Create GridLayout4
            app.GridLayout4 = uigridlayout(app.InputImagePanel);
            app.GridLayout4.ColumnWidth = {'1x'};
            app.GridLayout4.RowHeight = {'1x', 'fit'};

            % Create InputImage
            app.InputImage = uiimage(app.GridLayout4);
            app.InputImage.Layout.Row = 1;
            app.InputImage.Layout.Column = 1;

            % Create BrowseButton
            app.BrowseButton = uibutton(app.GridLayout4, 'push');
            app.BrowseButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseInputImage, true);
            app.BrowseButton.Layout.Row = 2;
            app.BrowseButton.Layout.Column = 1;
            app.BrowseButton.Text = 'Browse';

            % Create PlateROIDetectionPanel
            app.PlateROIDetectionPanel = uipanel(app.UIFigure);
            app.PlateROIDetectionPanel.Title = 'Plate ROI Detection';
            app.PlateROIDetectionPanel.Position = [342 152 371 447];

            % Create GridLayout3_2
            app.GridLayout3_2 = uigridlayout(app.PlateROIDetectionPanel);
            app.GridLayout3_2.ColumnWidth = {'1x'};
            app.GridLayout3_2.RowHeight = {'1x'};

            % Create PlateROIImage
            app.PlateROIImage = uiimage(app.GridLayout3_2);
            app.PlateROIImage.Layout.Row = 1;
            app.PlateROIImage.Layout.Column = 1;

            % Create ImageProcessingPlateNumberRecognitonPanel
            app.ImageProcessingPlateNumberRecognitonPanel = uipanel(app.UIFigure);
            app.ImageProcessingPlateNumberRecognitonPanel.Title = 'Image Processing Plate Number Recogniton';
            app.ImageProcessingPlateNumberRecognitonPanel.Position = [3 1 340 151];

            % Create ImageProcessingOutputLabel
            app.ImageProcessingOutputLabel = uilabel(app.ImageProcessingPlateNumberRecognitonPanel);
            app.ImageProcessingOutputLabel.HorizontalAlignment = 'center';
            app.ImageProcessingOutputLabel.Position = [57 64 228 22];
            app.ImageProcessingOutputLabel.Text = '';

            % Create CNNPlateNumberRecognitonPanel
            app.CNNPlateNumberRecognitonPanel = uipanel(app.UIFigure);
            app.CNNPlateNumberRecognitonPanel.Title = 'CNN Plate Number Recogniton';
            app.CNNPlateNumberRecognitonPanel.Position = [342 1 371 151];

            % Create CNNOutputLabel
            app.CNNOutputLabel = uilabel(app.CNNPlateNumberRecognitonPanel);
            app.CNNOutputLabel.HorizontalAlignment = 'center';
            app.CNNOutputLabel.Position = [73 64 227 22];
            app.CNNOutputLabel.Text = '';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end