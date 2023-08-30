% Need Image processing toolbox installed in matlab
% Load the TIF file
 
filename = 'input.tif';
info = imfinfo(filename);
num_slices = numel(info);
output_filename = 'output.tif';

for slice = 1:num_slices
    % Read the individual slice
    img = imread(filename, 'Index', slice, 'Info', info);
    
    % Convert to double for processing
    img = im2double(img);
    
    % Perform automatic brightness and contrast adjustment
    img_adjusted = imadjust(img, stretchlim(img), []);
    
    % Convert back to the original data type
    img_adjusted = im2uint8(img_adjusted);
    
    % Save the adjusted slice to the output TIF file
    if slice == 1
        imwrite(img_adjusted, output_filename, 'tif', 'WriteMode', 'overwrite');
    else
        imwrite(img_adjusted, output_filename, 'tif', 'WriteMode', 'append');
    end
end
