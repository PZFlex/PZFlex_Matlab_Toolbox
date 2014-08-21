function insertLine(line)
% To insert a string as a line in flex input file
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   line
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

fprintf(FID,'%s\n', line);

fclose(FID);