function endStatement(linename)
% The END$ statement identifies a line in the input command 
% file
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   linename
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

fprintf(FID,'end$ %s\n', linename);

fclose(FID);