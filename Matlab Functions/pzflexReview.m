function pzflexReview(bit, precision, filename)
% To run fileName in flex
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
% bit precision filename
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Call PZFlex from command line
ComStr = sprintf('review%d%s %s', bit, precision,filename);
system(ComStr);
