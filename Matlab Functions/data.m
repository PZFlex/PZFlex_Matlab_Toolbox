function data(SCOM, varargin)
% To provide the user with direct IO access to data manager arrays
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   form - option format (idtag)
%   hist - dataname nvalues filename
%   out  - dataname
%   polr - real imag option amp phase
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if data PCOM has already been called 
repeat=0;
FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'data';
while 1
    tline = fgetl(FID);
    % Break if we hit end of file, or the start marker
    if strcmp(tline, startString)
        repeat=1;
        break
    end
    if ~ischar(tline)
        break
    end
end

% Open file to write
FID = fopen('pzflex.flxinp','a');

% If first time calling data print data PCOM to flex file
if repeat==0
    fprintf(FID,'data\n');
end

% Determine which SCOM selected
form = strcmp (SCOM, 'form');
hist = strcmp (SCOM, 'hist');
out = strcmp (SCOM, 'out');
polr = strcmp (SCOM, 'polr');

% Apply selected SCOM to flex file
if form == 1
    if nargin == 3
        fprintf(FID, '\tform %s %s\n', varargin{1}, varargin{2});
    end
    if nargin == 4
        fprintf(FID, '\tform %s %s %s\n', varargin{1}, varargin{2}, varargin{3});
    end
end

if hist == 1
    fprintf(FID, '\thist %s %s %s\n', varargin{1}, varargin{2}, varargin{3});
end

if out == 1
    fprintf(FID,'\tout %s\n', varargin{1});
end

if polr == 1
    fprintf(FID,'\tpolr %s %s %s %s %s\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
end

fclose(FID);
