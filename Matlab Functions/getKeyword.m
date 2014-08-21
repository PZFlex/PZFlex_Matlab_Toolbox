function getKeyword(vname, function1)
% The #GET keyword allows one or more variables to be assigned 
% values by the program based on the function specified.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   vname function1
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

fprintf(FID,'symb #get { %s } %s\n', vname, function1);

fclose(FID);
