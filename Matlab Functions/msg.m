function msg(nl, varargin)
% The #MSG option allows messages to be sent to the Interactive User 
% (IU) at the terminal screen
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   nl line1string line2string . . .
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

fprintf(FID,'symb #msg %d\n', nl);  

for line = 1:nl
    fprintf(FID,'\t%s\n', varargin{line});    
end