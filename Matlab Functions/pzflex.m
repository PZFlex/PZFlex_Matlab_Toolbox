function pzflex(bit, precision, filename)
% To run fileName in flex
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
% bit precision filename
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Call PZFlex from command line
ComStr = sprintf('pzflex%d%s %s', bit, precision,filename);
system(ComStr);