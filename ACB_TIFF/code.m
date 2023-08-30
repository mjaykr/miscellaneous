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

% The above MATLAB code is designed to read a multi-slice TIF image file, perform automatic brightness and contrast adjustment on each slice, and then save the adjusted slices back into a new output TIF file. The code starts by reading metadata about the input TIF file using `imfinfo`, which provides information about the number of slices (`num_slices`) present in the TIF file. The code then loops through each slice using a `for` loop. Inside the loop, each individual slice is read into a variable named `img` using `imread`. The image data is converted to a double-precision format using `im2double` for more accurate numerical operations. Brightness and contrast are then adjusted using the `imadjust` function, which employs `stretchlim` to calculate the limits for contrast stretching. After adjustment, the image is converted back to an 8-bit unsigned integer format using `im2uint8`. Finally, the adjusted slice is written back to an output TIF file (`output_filename`) using `imwrite`. The 'WriteMode' parameter in `imwrite` is set to either 'overwrite' (for the first slice) or 'append' (for subsequent slices), ensuring that all slices are stored in the same TIF file.
