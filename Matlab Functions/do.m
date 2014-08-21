function do(varargin)
% The equivalent of Fortran 77 do loops are provided through the use of 
% the DO statement. It is used in conjunction with an END$ statement to 
% define the beginning and end of a do loop.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   doname dovariable nbegin nend (ninc)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

if nargin == 4
    fprintf(FID,'do %s %s %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});        
end

if nargin == 5
    fprintf(FID,'do %s %s %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
end

fclose(FID);