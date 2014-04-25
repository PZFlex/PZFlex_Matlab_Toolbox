function circ(SCOM, varargin)
% To define circuits.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   defn - circname
%   elem - type connect value
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if circ PCOM has already been called 
repeat=0;
FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'circ';
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

% If first time calling circ print circ PCOM to flex file
if repeat==0
    fprintf(FID,'circ\n');
end

% Determine which SCOM selected
defn = strcmp (SCOM, 'defn');
elem = strcmp (SCOM, 'elem');

% Apply selected SCOM to flex file
if defn == 1;
    fprintf(FID,'\tdefn %s\n', varargin{1});
end

if elem == 1;
    fprintf(FID,'\telem %s %s %f\n', varargin{1}, varargin{2}, varargin{3});
end

fclose(FID);