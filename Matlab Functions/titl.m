function titl(varargin)
% To provide titling information and identifiers for output results.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   id ititle
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

if nargin == 2
    fprintf(FID,'titl %s %s\n', varargin{1}, varargin{2});
end

fclose(FID);