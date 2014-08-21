function key(option, varargin)
% The #KEY options provide an expedient way to quickly define keypoint
% symbols for standard partition models.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   OPTION
%   keycord - direction indxbegin valuebegin dvalue1 (dvalue 2) (dvalue3)
%   keyindx - direction indxstart indxstop ivalindxstart spacing minval
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

% Determine which option selected
keycord = strcmp (option, 'keycord');
keyindx = strcmp (option, 'keyindx');

% Apply selected option to flex file
if keycord == 1
    if nargin == 5
        fprintf(FID, 'symb #keycord %s %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
    
    if nargin == 6
        fprintf(FID, 'symb #keycord %s %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
    end
    
    if nargin == 7
        fprintf(FID, 'symb #keycord %s %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
    end
end

if keyindx == 1
    fprintf(FID, 'symb #keyindx %s %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
end

fclose(FID);