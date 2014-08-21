function zone(varargin)
% To define a computational zone. A computational zone is a rectangular
% region in IJK space
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   ibegin iend (jbegin jend) (kbegin kend)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

if nargin == 2
     fprintf(FID,'zone * %d %d\n', varargin{1}, varargin{2});
end

if nargin == 4
     fprintf(FID,'zone * %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});  
end

if nargin == 6
    fprintf(FID,'zone * %d %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
end

fclose(FID);