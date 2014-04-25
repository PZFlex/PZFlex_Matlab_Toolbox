function grd(varargin)
% To define the number of nodes in the computational grid, the number of 
% dimensions for the model, and the appropriate constraint relations.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   igrid (jgrid) (kgrid)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

% Write appropriate grid command to flex input file
if nargin == 1
    fprintf(FID,'grid %d\r\n', varargin{1});
end

if nargin == 2
    fprintf(FID,'grid %d %d\r\n', varargin{1}, varargin{2});
end

if nargin == 3
    fprintf(FID,'grid %d %d %d\r\n', varargin{1}, varargin{2}, varargin{3});
end

fclose(FID);