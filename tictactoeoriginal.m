%HW#4
%Arjun Ramaswamy & Jason Fiammetta 
%tic tac toe with for loop
clear;clc;clf;
fprintf('Welcome to Tic Tac Toe\nPlease click on the desired block, to make your move\n');
board=zeros(1,9); %Blank board
okay=0;
greet=' ';
win=0;
figure(1);
hold on;
axis([1,15,1,15]);
x=[6,6,6,6,6,6,6]; y=[2,4,6,8,10,12,14];
plot(x,y,'k')
x2=[10,10,10,10,10,10,10]; y2=y;
plot(x2,y2,'k')
x3=y; y3=x;
plot(x3,y3,'k');
x4=y; y4=x2;
plot(x4,y4,'k');
xloc=0; yloc=0;


for turn=1:9
    player=-2*rem(turn,2)+1; %Decide whose turn it is
    %Set up the greeting phrase
    if player==-1
        greet='Player 1';
    elseif player==1
        greet='Player 2';
    end
        
    while ~okay %Don't move forward until it's okay
        fprintf('%s, make your move: \n',greet); %Ask for input
         [m,n]=ginput(1);
        if m>=2&&m<=6&&n>=10&&n<=14
           a=1;
         end
         if m>=2&&m<=6&&n>=6&&n<=10
             a=4;
         end
         if m>=2&&m<=6&&n>=2&&n<=6
             a=7;
         end
         if m>=6&&m<=10&&n>=10&&n<=14
             a=2;
         end
         if m>=6&&m<=10&&n>=6&&n<=10
             a=5;
         end
         if m>=6&&m<=10&&n>=2&&n<=6
             a=8;
         end
         if m>=10&&m<=14&&n>=10&&n<=14
             a=3;
         end
         if m>=10&&m<=14&&n>=6&&n<=10
             a=6;
         end
         if m>=10&&m<=14&&n>=2&&n<=6
             a=9;
         end
         
         if isnumeric(a) && a>=1 && a<10 && floor(a)==a %Checks
             if board(a)==0 %Checks
                 okay=1; %Okay to move forward
                 board(a)=player;
                 if rem(a,3)==1
                     %first column
                     xloc=4;
                 elseif rem(a,3)==2
                     %second column
                     xloc=8;
                 elseif rem(a,3)==0
                     %third column
                     xloc=12;
                 end
                 if a<4
                     %first row
                     yloc=12;
                 elseif a>=4&&a<7
                     %second row
                     yloc=8;
                 elseif a>=7
                     %third row
                     yloc=4;
                 end
                 if player==-1
                     plot(xloc,yloc,'X','Markersize',40,'MarkerEdgeColor','b');
                 end
                 if player==1
                     plot(xloc,yloc,'O','Markersize',40,'MarkerEdgeColor','r');
                 end
             else
                 display('That square is already taken. Try again.'); %Failed checks
             end
         else
             display('Invalid input. Try again.'); %Failed checks
         end
    end
    okay=0; %Reset okay
    %Win check
    %Rows
    if abs(sum(board(1:3)))==3||abs(sum(board(4:6)))==3||abs(sum(board(7:9)))==3
        warndlg(strcat(greet,' wins!'));
        win=1;
        break
    end
    %Columns
    if abs(sum(board(1:3:9)))==3||abs(sum(board(2:3:9)))==3||abs(sum(board(3:3:9)))==3
        warndlg(strcat(greet,' wins!'));
        win=1;
        break
    end
    %Diagonals
    if abs(sum(board(3:2:7)))==3||abs(sum(board(1:4:9)))==3
        warndlg(strcat(greet,' wins!'));
        win=1;
        break
    end 
end
if ~win  %If no one has won by this point, draw
    warndlg('It''s a draw!')
end

