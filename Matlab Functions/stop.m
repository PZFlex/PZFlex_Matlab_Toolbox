function stop()
% To terminate the processing of a job in an orderly manner
%
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

fprintf(FID,'stop\n');

fclose(FID);