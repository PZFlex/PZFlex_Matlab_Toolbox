function geom(SCOM, varargin)
% To define nodal coordinates for the model.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   xcrd   - xbegin xend ibegin iend (ratio)
%   ycrd   - ybegin yend jbegin jend (ratio)
%   zcrd   - zbegin zend kbegin kend (ratio)
%   keypnt - nikey njkey nkkey
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if geom PCOM has already been called 
repeat=0;
FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'geom';
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

% If first time calling geom print geom PCOM to flex file
if repeat==0
    fprintf(FID,'geom\n');
end

% Determine which SCOM selected
xcrd = strcmp (SCOM, 'xcrd');
ycrd = strcmp (SCOM, 'ycrd');
zcrd = strcmp (SCOM, 'zcrd');
keypnt = strcmp (SCOM, 'keypnt');

% Apply selected SCOM to flex file
if xcrd == 1;
    if nargin == 5
        fprintf(FID,'\txcrd %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
    if nargin == 6
        fprintf(FID,'\txcrd %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
    end
end

if ycrd == 1;
    if nargin == 5
        fprintf(FID,'\tycrd %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
    if nargin == 6
        fprintf(FID,'\tycrd %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
    end
end

if zcrd == 1;
    if nargin == 5
        fprintf(FID,'\tzcrd %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
    if nargin == 6
        fprintf(FID,'\tzcrd %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
    end
end

if keypnt == 1;
    fprintf(FID,'\tkeypnt %d %d %d\n', varargin{1}, varargin{2}, varargin{3});
end

fclose(FID);
