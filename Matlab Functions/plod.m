function plod(SCOM, varargin)
% To provide the option of applying pressure loads on any surface of any
% continuum element in the grid.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   pdef - plodname presname
%   vctr - vectorname vx (vy) (vz)
%   sdef - plodname direcname ibegin iend (jbegin jend) (kbegin kend)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if plod PCOM has already been called 
repeat=0;
FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'plod';
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

% If first time calling plod print plod PCOM to flex file
if repeat==0
    fprintf(FID,'plod\n');
end

% Determine which SCOM selected
pdef = strcmp (SCOM, 'pdef');
vctr = strcmp (SCOM, 'vctr');
sdef = strcmp (SCOM, 'sdef');

% Apply selected SCOM to flex file
if pdef == 1;
    fprintf(FID,'\tpdef %s %s\n', varargin{1}, varargin{2});
end

if vctr == 1;
    if nargin == 3
        fprintf(FID,'\tvctr %s %d\n', varargin{1}, varargin{2});
    end
    if nargin == 4
        fprintf(FID,'\tvctr %s %d %d\n', varargin{1}, varargin{2}, varargin{3});
    end
    if nargin == 5
        fprintf(FID,'\tvctr %s %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
end

if sdef == 1;
    if nargin == 5
        fprintf(FID,'\tsdef %s %s %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
    if nargin == 7
        fprintf(FID,'\tsdef %s %s %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
    end
    if nargin == 9
        fprintf(FID,'\tsdef %s %s %d %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7}, varargin{8});
    end
end

fclose(FID);

