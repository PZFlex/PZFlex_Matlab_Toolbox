function term()
% To allow the user to control the routing of standard input and output 
% files to the terminal or to the Job Input and Job Output Files.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

fprintf(FID,'term\n');

fclose(FID);