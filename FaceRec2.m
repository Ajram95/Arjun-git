%Arjun Ramaswamy, Final Integrated Project: Facial Recognition
%GE1111, 10:30-11:35 am, MWR
%Professor Jennifer Love
%Program 3
filename = 'sumscores.txt';
delimiter = ' ';

%% Read columns of data as strings:
formatSpec = '%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

% Converts strings in the input cell array to numbers. Replaced non-numeric
% strings with NaN.
rawData = dataArray{1};
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
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch me
    end
end


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Allocate imported array to column variable names
sumscores = cell2mat(raw(:, 1));


%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me R;
candidates = {'DavidOrtiz';'MarieCurie';'TomBrady';'EleanorRigby';'SnidleyWhiplash';'DudleyDooright';'BugsBunny';'DonaldDuck';'SylvesterCat';'HawkeyePearce';'MrMagoo';'LanceArmstrong';'FrankZappa';'TennesseeTuxedo';'EltonJohn';'ShirleyTemple';'GeorgeCostanza';'MargeSimpson';'MichaelCaine';'RockyBalboa';'HarryPotter';'BilboBaggins';'RoadRunner';'WileyCoyot';'SpiderMan'};

%Table 1 
%Creating a table to show scores of all candidates when tested with
%suspect1
sumscorefortest1 = sumscores(2:26);
supect1test = table(candidates,sumscorefortest1)

%Table 2
%Creating a table to show scores of all candidates when tested with
%suspect2
sumscorefortest2 = sumscores(28:52);
suspect2test = table(candidates,sumscorefortest2)

%Table 3
%Creating a table to show scores of all candidates when tested with
%suspecr3
sumscorefortest3 = sumscores(54:78);
suspect3test = table(candidates,sumscorefortest3)



%Identifying potentials suspects from results

%Results for Suspect 1
%Sorting sumsquare values in increasing order
sort(sumscorefortest1);
%First 4 values will be the top 4 potential candidates for suspect 1
%From the table suspect1test it can be seen that
%Top candidates for suspect 1 after sorting the data: 


figure('Name','CandidatesforSuspect1')
%1)Sumscore of 0.0067 - Rocky Balboa
RBx=[facedata(60,1),facedata(60,2),facedata(60,3),facedata(60,4),facedata(60,5),facedata(60,1)];
RBy=[facedata(61,1),facedata(61,2),facedata(61,3),facedata(61,4),facedata(61,5),facedata(61,1)];
subplot(2,2,1)
plot(RBx,RBy,'-')
str = {'Score = 0.0067'};
annotation('textbox',[0.2,0.7,0.1,0.1],'String',str)
title('Rocky  Balboa')

%2)Sumscore of 0.0147 - Harry Potter
HPx=[facedata(63,1),facedata(63,2),facedata(63,3),facedata(63,4),facedata(63,5),facedata(63,1)];
HPy=[facedata(64,1),facedata(64,2),facedata(64,3),facedata(64,4),facedata(64,5),facedata(64,1)];
subplot(2,2,2)
plot(HPx,HPy,'-')
str = {'Score = 0.0147'};
annotation('textbox',[0.7,0.7,0.1,0.1],'String',str)
title('Harry Potter')

%3)Sumscore of 0.0242 - Michael Caine
MCx=[facedata(57,1),facedata(57,2),facedata(57,3),facedata(57,4),facedata(57,5),facedata(57,1)];
MCy=[facedata(58,1),facedata(58,2),facedata(58,3),facedata(58,4),facedata(58,5),facedata(58,1)];
subplot(2,2,3)
plot(MCx,MCy,'-')
str = {'Score = 0.0242'};
annotation('textbox',[0.2,0.2,0.1,0.1],'String',str)
title('Michael Caine')

%4)Sumscore of 0.0482 - Bilbo Baggins
BBx=[facedata(66,1),facedata(66,2),facedata(66,3),facedata(66,4),facedata(66,5),facedata(66,1)];
BBy=[facedata(67,1),facedata(67,2),facedata(67,3),facedata(67,4),facedata(67,5),facedata(67,1)];
subplot(2,2,4)
plot(BBx,BBy,'-')
str = {'Score = 0.0482'};
annotation('textbox',[0.7,0.2,0.1,0.1],'String',str)
title('Bilbo Baggins')




%Results for Suspect 2
%Sorting sumsquare values in increasing order
sort(sumscorefortest2);
%First 4 values will be the top 4 potential candidates for suspect 2
%From the table supect2test it can bee seen that
%Top candidates for suspect 2 after sorting the data
figure('Name','CandidatesforSuspect2')
%1)Sumscore of 0.0004 Bugs Bunny
BYx=[facedata(21,1),facedata(21,2),facedata(21,3),facedata(21,4),facedata(21,5),facedata(21,1)];
BYy=[facedata(22,1),facedata(22,2),facedata(22,3),facedata(22,4),facedata(22,5),facedata(22,1)];
subplot(2,2,1)
plot(BYx,BYy,'-')
str = {'Score = 0.0004'};
annotation('textbox',[0.2,0.7,0.1,0.1],'String',str)
title('Bugs Bunny')
%2)Sumscore of 0.0095 Dudley Dooright  
DUx=[facedata(18,1),facedata(18,2),facedata(18,3),facedata(18,4),facedata(18,5),facedata(18,1)];
DUy=[facedata(19,1),facedata(19,2),facedata(19,3),facedata(19,4),facedata(19,5),facedata(19,1)];
subplot(2,2,2)
plot(DUx,DUy,'-')
str = {'Score = 0.0095'};
annotation('textbox',[0.7,0.7,0.1,0.1],'String',str)
title('Dudley Dooright')

%3)Sumscore of 0.0152 Donald Duck
DDx=[facedata(24,1),facedata(24,2),facedata(24,3),facedata(24,4),facedata(24,5),facedata(24,1)];
DDy=[facedata(25,1),facedata(25,2),facedata(25,3),facedata(25,4),facedata(25,5),facedata(25,1)];
subplot(2,2,3)
plot(DDx,DDy,'-')
str = {'Score = 0.0152'};
annotation('textbox',[0.2,0.2,0.1,0.1],'String',str)
title('Donald Duck')
%4)Sumscore of 0.0422 Snidley Whiplash
SWx=[facedata(15,1),facedata(15,2),facedata(15,3),facedata(15,4),facedata(15,5),facedata(15,1)];
SWy=[facedata(16,1),facedata(16,2),facedata(16,3),facedata(16,4),facedata(16,5),facedata(16,1)];
subplot(2,2,4)
plot(SWx,SWy,'-')
str = {'Score = 0.0422'};
annotation('textbox',[0.7,0.2,0.1,0.1],'String',str)
title('Snidley Whiplash')



%Results for Suspect 3
%Sorting sumsquares values in increasing order
sort(sumscorefortest3);
%First 4 values will be the top 4 potential candidates for suspect 3
%From the table suspect3test it can be seen that
%Top candidates for suspect 3 after sorting the data
figure('Name','CandidatesforSuspect3')
%1)Sumscore of 0.0015 Tennessee Tuxedo
TTx=[facedata(42,1),facedata(42,2),facedata(42,3),facedata(42,4),facedata(42,5),facedata(42,1)];
TTy=[facedata(43,1),facedata(43,2),facedata(43,3),facedata(43,4),facedata(43,5),facedata(43,1)];
subplot(2,2,1)
plot(TTx,TTy,'-')
str = {'Score = 0.0015'};
annotation('textbox',[0.2,0.7,0.1,0.1],'String',str)
title('Tennessee Tuxedo')
%2)Sumscore of 0.0123 Frank Zappa
FZx=[facedata(39,1),facedata(39,2),facedata(39,3),facedata(39,4),facedata(39,5),facedata(39,1)];
FZy=[facedata(40,1),facedata(40,2),facedata(40,3),facedata(40,4),facedata(40,5),facedata(40,1)];
subplot(2,2,2)
plot(FZx,FZy,'-')
str = {'Score = 0.0123'};
annotation('textbox',[0.7,0.7,0.1,0.1],'String',str)
title('Frank Zappa')
%3)Sumscore of 0.0156 Elton John
EJx=[facedata(45,1),facedata(45,2),facedata(45,3),facedata(45,4),facedata(45,5),facedata(45,1)];
EJy=[facedata(46,1),facedata(46,2),facedata(46,3),facedata(46,4),facedata(46,5),facedata(46,1)];
subplot(2,2,3)
plot(EJx,EJy,'-')
str = {'Score = 0.0156'};
annotation('textbox',[0.2,0.2,0.1,0.1],'String',str)
title('Elton John')
%4)Sumscore of 0.0478 Lance Armstrong
LAx=[facedata(36,1),facedata(36,2),facedata(36,3),facedata(36,4),facedata(36,5),facedata(36,1)];
LAy=[facedata(37,1),facedata(37,2),facedata(37,3),facedata(37,4),facedata(37,5),facedata(37,1)];
subplot(2,2,4)
plot(LAx,LAy,'-')
str = {'Score = 0.0478'};
annotation('textbox',[0.7,0.2,0.1,0.1],'String',str)
title('Lance Armstrong')


% Comparing the number 1 candidate with each of the suspect

%Plotting suspect 1 and the most likely candidate (overlapping graph to
%show similarites 

figure('Name','Suspect1andCandidate')
%Coordinates of suspect 1
s1x=[s1x1y1(1),s1x2y2(1),s1x3y3(1),s1x4y4(1),s1x5y5(1),s1x1y1(1)];
s1y=[s1x1y1(2),s1x2y2(2),s1x3y3(2),s1x4y4(2),s1x5y5(2),s1x1y1(2)];
plot(s1x,s1y,'-')
hold on
%Coordinates of most likely candidate (Rocky Balboa)
plot(RBx,RBy,'-')
legend('Suspect 1','Rocky Balboa')


%Plotting suspect 2 and the most likely candidate (overlapping graph to
%show similarities

figure('Name','Suspect2andCandidate')
%Coordinates of suspect 2
s2x=[s2x1y1(1),s2x2y2(1),s2x3y3(1),s2x4y4(1),s2x5y5(1),s2x1y1(1)];
s2y=[s2x1y1(2),s2x2y2(2),s2x3y3(2),s2x4y4(2),s2x5y5(2),s2x1y1(2)];
plot(s2x,s2y,'-')
hold on
%Coordinates of most likely candidate (Bugs Bunny)
plot(BYx,BYy,'-')
legend('Suspect 2','Bugs Bunny')


%Plotting suspect 4 and the most likely candidate (overlapping graph to
%show similarities
figure('Name','Suspect3andCandidate')
%Coordinates of suspect 3
s3x=[s3x1y1(1),s3x2y2(1),s3x3y3(1),s3x4y4(1),s3x5y5(1),s3x1y1(1)];
s3y=[s3x1y1(2),s3x2y2(2),s3x3y3(2),s3x4y4(2),s3x5y5(2),s3x1y1(2)];
plot(s3x,s3y,'-')
hold on 
%Coordinates of most likely candidate (Tennessee Tuxedo)
plot(TTx,TTy,'-')
legend('Suspect 3','Tennessee Tuxedo')


%Printing out a text file with scores of top candidates for each suspect

%scoresuspect1.txt
suspects1= {'Rocky Balboa';'Harry Potter';'Michael Caine';'Bilbo Baggins'};
scores1 = [sumscores(21);sumscores(22);sumscores(20);sumscores(23)];
candidatesforsuspect1 = table(suspects1,scores1);
writetable(candidatesforsuspect1,'scoresuspect1','Delimiter',' ')


%scoresuspect2.txt
suspects2= {'Bugs Bunny';'Dudley Dooright';'Donald Duck';'Snidley Whiplash'};
scores2 = [sumscores(34);sumscores(33);sumscores(35);sumscores(32)];
candidatesforsuspect2 = table(suspects2,scores2);
writetable(candidatesforsuspect2,'scoresuspect2','Delimiter',' ')

%scoresuspect3.txt
suspects3= {'Tennessee Tuxedo';'Frank Zappa';'Elton John';'Lance Armstrong'};
scores3 = [sumscores(67);sumscores(66);sumscores(68);sumscores(65)];
candidatesforsuspect3 = table(suspects3,scores3);
writetable(candidatesforsuspect3,'scoresuspect3','Delimiter',' ')

