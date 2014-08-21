function time(varargin)
% To allow the user to control the model time step and initial time
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   timebegin (timefactor)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Open file to write
FID = fopen('pzflex.flxinp','a');

if nargin == 1
     fprintf(FID,'time * %d\n', varargin{1});
end

if nargin == 2
     fprintf(FID,'time * %d %d\n', varargin{1}, varargin{2});  
end