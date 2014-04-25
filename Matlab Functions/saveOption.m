function saveOption(fname)
% The #SAVE option allows the current list of symbols and their values to 
% be saved on a specified disk file
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   fname
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

fprintf(FID,'symb #save ''%s''\n', fname);

fclose(FID);
