function exec(varargin)
% To compute the response of the model.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   ntime
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

if nargin == 1
    fprintf(FID,'exec %s\n', varargin{1});
end

fclose(FID);