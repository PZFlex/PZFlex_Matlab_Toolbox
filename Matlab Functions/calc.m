function calc(SCOM, varargin)
% To specify secondary field variables and energy quantities to be 
% computed and stored during execution. Secondary field variables are 
% nodal and elemental quantities that the computational algorithm does 
% not require to be stored during the computation.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   avrg - avgname arrayname weightoption region ibeg iend (jbeg jend) (kbeg kend)
%          OR
%        - avgname arrayname weightoption NO2 mat1 mat2 rootopt ibeg iend (jbeg jend) (kbeg kend)
%   disp - none
%   max  - dataname minname maxname
%   pres - none
%   strs - none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if calc PCOM has already been called 
repeat=0;
FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'calc';
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

% If first time calling calc print calc PCOM to flex file
if repeat==0
    fprintf(FID,'calc\n');
end

% Determine which SCOM selected
avrg = strcmp (SCOM, 'avrg');
disp = strcmp (SCOM, 'disp');
max = strcmp (SCOM, 'max');
pres = strcmp (SCOM, 'pres');
strs = strcmp (SCOM, 'strs');

% Apply selected SCOM to flex file
if avrg == 1;
    if nargin == 7;
        fprintf(FID,'\tavrg %s %s %s %s %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
    end
    if nargin == 9;
        fprintf(FID,'\tavrg %s %s %s %s %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7}, varargin{8});
    end
    if nargin == 10;
        fprintf(FID,'\tavrg %s %s %s %s %s %s %s %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7}, varargin{8}, varargin{9});
    end
    if nargin == 11;
        fprintf(FID,'\tavrg %s %s %s %s %d %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7}, varargin{8}, varargin{9}, varargin{10});
    end
    if nargin == 12;
        fprintf(FID,'\tavrg %s %s %s %s %s %s %s %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7}, varargin{8}, varargin{9}, varargin{10}, varargin{11});
    end
    if nargin == 14;
        fprintf(FID,'\tavrg %s %s %s %s %s %s %s %d %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7}, varargin{8}, varargin{9}, varargin{10}, varargin{11}, varargin{12}, varargin{13});
    end
end

if  disp == 1;
    fprintf(FID,'\tdisp\n');
end

if max == 1;
    fprintf(FID,'\tmax %s %s %s\n', varargin{1}, varargin{2}, varargin{3});
end

if  pres == 1;
    fprintf(FID,'\tpres\n');
end

if  strs == 1;
    fprintf(FID,'\tstrs\n');
end

fclose(FID);