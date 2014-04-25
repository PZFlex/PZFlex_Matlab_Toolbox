function extr(SCOM, varargin)
% To create an output data file (flxext) for use in various types of 
% extrapolation using Review
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   ref  - refoption xref (yref) (zref)
%   defn - extoption
%   driv - driv_array
%   node - ibegin iend (jbegin jend) (kbegin kend)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if extr PCOM has already been called 
repeat=0;
FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'extr';
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

FID = fopen('pzflex.flxinp','a');

% If first time calling extr print extr PCOM to flex file
if repeat==0
    fprintf(FID,'extr\n');
end

% Determine which SCOM selected
ref = strcmp (SCOM, 'ref');
defn = strcmp (SCOM, 'defn');
driv = strcmp (SCOM, 'driv');
node = strcmp (SCOM, 'node');

% Apply selected SCOM to flex file
if ref == 1;
    if nargin == 3
         fprintf(FID,'\tref %s %d\n', varargin{1}, varargin{2});
    end
    if nargin == 4
         fprintf(FID,'\tref %s %d %d\n', varargin{1}, varargin{2}, varargin{3});
    end
    if nargin == 5
        fprintf(FID,'\tref %s %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
end

if defn == 1;
    fprintf(FID,'\tdefn %s\n', varargin{1});
end

if driv == 1;
    fprintf(FID,'\tdriv %s\n', varargin{1});
end

if node == 1;
    if nargin == 3
         fprintf(FID,'\tnode %d %d\n', varargin{1}, varargin{2});       
    end
    if nargin == 5
        fprintf(FID,'\tnode %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});       
    end
    if nargin == 7
        fprintf(FID,'\tnode %d %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
    end
end

fclose(FID);