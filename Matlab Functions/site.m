function site(SCOM, varargin)
% To define the site model by assigning material properties to each 
% continuum element of the grid.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   cyln     - matname iaxis center1 center2 radbegin radend
%   regn     - matname (ibegin iend) (jbegin jend) (kbegin kend)
%   regndupl - ibegf iendf jbegf jendf (kbegf kendf) dupdir ncopy (invertopt)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if site PCOM has already been called 
repeat=0;
FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'site';
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

% If first time calling site print site PCOM to flex file
if repeat==0
    fprintf(FID,'site\n');
end

% Determine which SCOM selected
cyln = strcmp (SCOM, 'cyln');
regn = strcmp (SCOM, 'regn');
regndupl = strcmp (SCOM, 'regndupl');

% Apply selected SCOM to flex file
if cyln == 1;
    fprintf(FID,'\tcyln %s %s 0. 0. %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
end

if regn == 1;
    if nargin == 2
        fprintf(FID,'\tregn %s\n', varargin{1});
    end
    if nargin == 4
        fprintf(FID,'\tregn %s %d %d\n', varargin{1}, varargin{2}, varargin{3});
    end
    if nargin == 6
        fprintf(FID,'\tregn %s %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
    end
    if nargin == 8
        fprintf(FID,'\tregn %s %d %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7});
    end
end

if regndupl == 1;
    % regndupl ibegf iendf jbegf jendf dupdir ncopy
    if nargin == 7
        fprintf(FID,'\tregndupl %d %d %d %d %s %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
    end
    % regndupl ibegf iendf jbegf jendf dupdir ncopy invertopt
    if nargin == 8
        fprintf(FID,'\tregndupl %d %d %d %d %s %d %s\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7});
    end
    % regndupl ibegf iendf jbegf jendf kbegf kendf dupdir ncopy
    if nargin == 9
        fprintf(FID,'\tregndupl %d %d %d %d %d %d %s %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7}, varargin{8});
    end
    % regndupl ibegf iendf jbegf jendf kbegf kendf dupdir ncopy invertopt
    if nargin == 10
        fprintf(FID,'\tregndupl %d %d %d %d %d %d %s %d %s\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7}, varargin{8}, varargin{9});
    end
end

fclose(FID);

