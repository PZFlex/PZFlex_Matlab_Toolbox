function boun(SCOM, varargin)
% To assign boundary conditions to the grid boundary surfaces.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   side - xmin xmax (ymin ymax) (zmin zmax)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if boun PCOM has already been called 
repeat=0;
FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'boun';
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

% If first time calling boun print boun PCOM to flex file
if repeat==0
    fprintf(FID,'boun\n');
end

% Determine which SCOM selected
side = strcmp (SCOM, 'side');

% Apply selected SCOM to flex file
if side == 1;
    fprintf(FID,'\tside xmin %s\r\n', varargin{1});
    fprintf(FID,'\tside xmax %s\r\n', varargin{2});

    if nargin > 4
        fprintf(FID,'\tside ymin %s\r\n', varargin{3});
        fprintf(FID,'\tside ymax %s\r\n', varargin{4});
    end

    if nargin > 6
        fprintf(FID,'\tside zmin %s\r\n', varargin{5});
        fprintf(FID,'\tside zmax %s\r\n', varargin{6});
    end
    
end

fclose(FID);