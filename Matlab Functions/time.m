function time(varargin)
% To allow the user to control the model time step and initial time
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   timestep (timebegin) (timefactor)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Open file to write
FID = fopen('pzflex.flxinp','a');

if nargin == 1
    fprintf(FID,'time %s\n', varargin{1});
end

if nargin == 2
    fprintf(FID,'time %s %s\n', varargin{1}, varargin{2});
end

if nargin == 3
    fprintf(FID,'time %s %s %s\n', varargin{1}, varargin{2}, varargin{3});
end

fclose(FID);