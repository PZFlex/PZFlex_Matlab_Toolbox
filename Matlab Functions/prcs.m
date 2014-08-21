function prcs()
% To construct an internal formulation of the defined problem to allow 
% efficient solution of the model's response.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

fprintf(FID,'prcs\n');

fclose(FID);