function pout(SCOM, varargin)
% To provide a quick way to view output results without requiring 
% additional postprocessing.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   form     - format idtag
%   hist     - datanames (ibegin iend iinc) (jbegin jend jinc) (kbegin kend kinc)
%   histname - OBJECT_TYPE option object_name
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if pout PCOM has already been called 
repeat=0;
FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'pout';
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

% If first time calling pout print pout PCOM to flex file
if repeat==0
    fprintf(FID,'pout\n');
end

% Determine which SCOM selected
form = strcmp (SCOM, 'form');
hist = strcmp (SCOM, 'hist');
histname = strcmp (SCOM, 'histname');

% Apply selected SCOM to flex file
if form == 1;
    if nargin == 2
        fprintf(FID,'\tform %s\n', varargin{1});
    end
    if nargin == 3
        fprintf(FID,'\tform %s %s\n', varargin{1}, varargin{2});
    end
end

if hist == 1;
    if nargin == 2
        fprintf(FID,'\thist %s\n', varargin{1});
    end
    if nargin == 5
        fprintf(FID,'\thist %s %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
    if nargin == 8
        fprintf(FID,'\thist %s %d %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7});
    end
    if nargin == 11
        fprintf(FID,'\thist %s %d %d %d %d %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7}, varargin{8}, varargin{9}, varargin{10});
    end
end

if histname == 1;
    fprintf(FID,'\thistname %s %s %s\n', varargin{1}, varargin{2}, varargin{3});
end

fclose(FID);