%Arjun Ramaswamy, Final Integrated Project: Facial Recognition
%GE1111, 10:30-11:35 am, MWR
%Professor Jennifer Love
%Program 1


%Reading and Importing facedata.txt (file that contains data of 25
%candidates
filename = 'facedata.txt';
delimiter = '\t';

%% Read columns of data as strings:
formatSpec = '%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,5]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
%% Create output variable
facedata = cell2mat(raw);
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me R;

%Importing unknown suspect 1 data 
filename = 'suspect_1.txt';
delimiter = '\t';
formatSpec = '%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
s1x1y1 = dataArray{:, 1};
s1x2y2 = dataArray{:, 2};
s1x3y3 = dataArray{:, 3};
s1x4y4 = dataArray{:, 4};
s1x5y5 = dataArray{:, 5};
clearvars filename delimiter formatSpec fileID dataArray ans;

%Importing unknown supect 2 data
filename = 'suspect_2.txt';
delimiter = '\t';
formatSpec = '%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
s2x1y1 = dataArray{:, 1};
s2x2y2 = dataArray{:, 2};
s2x3y3 = dataArray{:, 3};
s2x4y4 = dataArray{:, 4};
s2x5y5 = dataArray{:, 5};
clearvars filename delimiter formatSpec fileID dataArray ans;

%Importing unknown suspect 3 data
filename = 'suspect_3.txt';
delimiter = '\t';
formatSpec = '%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
s3x1y1 = dataArray{:, 1};
s3x2y2 = dataArray{:, 2};
s3x3y3 = dataArray{:, 3};
s3x4y4 = dataArray{:, 4};
s3x5y5 = dataArray{:, 5};
clearvars filename delimiter formatSpec fileID dataArray ans;

%Calculating Suspect 1: 5 distances
%Suspect 1 distance 1
s1d1 = sqrt((s1x1y1(1)-s1x2y2(1))^2+(s1x1y1(2)-s1x2y2(2))^2);
%Suspect 1 distance 2
s1d2 = sqrt((s1x2y2(1)-s1x3y3(1))^2+(s1x2y2(2)-s1x3y3(2))^2);
%Suspect 1 distance 3
s1d3 = sqrt((s1x3y3(1)-s1x4y4(1))^2+(s1x3y3(2)-s1x4y4(2))^2);
%Suspect 1 distance 4
s1d4 = sqrt((s1x4y4(1)-s1x5y5(1))^2+(s1x4y4(2)-s1x5y5(2))^2);
%Suspect 1 distance 5
s1d5 = sqrt((s1x5y5(1)-s1x1y1(1))^2+(s1x5y5(2)-s1x1y1(2))^2);

%Calculating Suspect 2: 5 distances 
%Suspect 2 distance 1
s2d1 = sqrt((s2x1y1(1)-s2x2y2(1))^2+(s2x1y1(2)-s2x2y2(2))^2);
%Suspect 2 distance 2
s2d2 = sqrt((s2x2y2(1)-s2x3y3(1))^2+(s2x2y2(2)-s2x3y3(2))^2);
%Suspect 2 distance 3
s2d3 = sqrt((s2x3y3(1)-s2x4y4(1))^2+(s2x3y3(2)-s2x4y4(2))^2);
%Suspect 2 distance 4
s2d4 = sqrt((s2x4y4(1)-s2x5y5(1))^2+(s2x4y4(2)-s2x5y5(2))^2);
%Suspect 2 distance 5
s2d5 = sqrt((s2x5y5(1)-s2x1y1(1))^2+(s2x5y5(2)-s2x1y1(2))^2);


%Calcuating Suspect 3: 5 distances 
%Suspect 3 distance 1
s3d1 = sqrt((s3x1y1(1)-s3x2y2(1))^2+(s3x1y1(2)-s3x2y2(2))^2);
%Suspect 3 distance 2
s3d2 = sqrt((s3x2y2(1)-s3x3y3(1))^2+(s3x2y2(2)-s3x3y3(2))^2);
%Suspect 3 distance 3
s3d3 = sqrt((s3x3y3(1)-s3x4y4(1))^2+(s3x3y3(2)-s3x4y4(2))^2);
%Suspect 3 distance 4
s3d4 = sqrt((s3x4y4(1)-s3x5y5(1))^2+(s3x4y4(2)-s3x5y5(2))^2);
%Suspect 3 distance 5
s3d5 = sqrt((s3x5y5(1)-s3x1y1(1))^2+(s3x5y5(2)-s3x1y1(2))^2);

%while loop for calculating the 5 facial distances for each of the 25
%candidates

n=1;
i = 3; 

while i<=75
        d1(n) = sqrt((facedata(i,1)-facedata(i,2))^2+(facedata(i+1,1)-facedata(i+1,2))^2);
        d2(n) = sqrt((facedata(i,2)-facedata(i,3))^2+(facedata(i+1,2)-facedata(i+1,3))^2);
        d3(n) = sqrt((facedata(i,3)-facedata(i,4))^2+(facedata(i+1,3)-facedata(i+1,4))^2);
        d4(n) = sqrt((facedata(i,4)-facedata(i,5))^2+(facedata(i+1,4)-facedata(i+1,5))^2);
        d5(n) = sqrt((facedata(i,5)-facedata(i,1))^2+(facedata(i+1,5)-facedata(i+1,1))^2);
i = i + 3;
n=n+1; 
end

% Creating table for transferring to C++ to calculate sumsquares
%Table 1 containing 5 distances of all 25 candidates
T1 = table(d1',d2',d3',d4',d5');
%Table 2 containing 5 distances of all 3 suspects
T2 = table(s1d1,s1d2,s1d3,s1d4,s1d5,s2d1,s2d2,s2d3,s2d4,s2d5,s3d1,s3d2,s3d3,s3d4,s3d5);
%Writing the 2 tables out as excel file for C++ to read
filename = 'facialdistances.xlsx';
writetable(T1,filename,'Sheet',1,'Range','A1')
filename = 'suspectsfacialdistances.xlsx';
writetable(T2,filename,'Sheet',1,'Range','A1')


