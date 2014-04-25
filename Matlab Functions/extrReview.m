function extrReview(SCOM, varargin)
% To extrapolate pressure through a homogeneous acoustic medium using the 
% FLXEXT data file from a PZFlex computation
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   data - pathname1
%   file - filename
%   freq - frequency (attenuation)
%   slvr - slvrtype
%   surf - quad axisname ni nj x1 y1 z1 x2 y2 z2 x3 y3 z3 x4 y4 z4
%   spot - x (y) (z)
%   type - option
%   calc - (quad_order) (sort_opt) (nsection) (length) (iprint)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if extrReview PCOM has already been called 
repeat=0;
FID = fopen('review.revinp');
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

% Open file to write
FID = fopen('review.revinp','a');

% If first time calling extrReview print extrReview PCOM to review file
if repeat==0
    fprintf(FID,'extr\n');
end

% Determine which SCOM selected
data = strcmp (SCOM, 'data');
file = strcmp (SCOM, 'file');
freq = strcmp (SCOM, 'freq');
slvr = strcmp (SCOM, 'slvr');
surf = strcmp (SCOM, 'surf');
spot = strcmp (SCOM, 'spot');
type = strcmp (SCOM, 'type');
calc = strcmp (SCOM, 'calc');

% Apply selected SCOM to review file
if  data == 1
    fprintf(FID,'\tdata %s\n', varargin{1});  
end

if file == 1
    fprintf(FID,'\tfile %s\n', varargin{1});
end

if freq == 1
   if nargin == 2
      fprintf(FID,'\tfreq %d\n', varargin{1}); 
   end
   if nargin == 3
      fprintf(FID,'\tfreq %d %d\n', varargin{1}, varargin{2}); 
   end
end

if slvr == 1
    fprintf(FID,'\tslvr %s\n', varargin{1});
end

if surf == 1
    fprintf(FID,'\tsurf %s %s %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n', varargin{1}, varargin{2}, ...
                varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7}, varargin{8}, varargin{9}, varargin{10}, ...
                 varargin{11}, varargin{12}, varargin{13}, varargin{14}, varargin{15}, varargin{16});
end

if spot == 1
    if nargin == 2
        fprintf(FID,'\tspot %d\n', varargin{1});
    end
    if nargin == 3
        fprintf(FID,'\tspot %d %d\n', varargin{1}, varargin{2});
    end
    if nargin == 4
        fprintf(FID,'\tspot %d %d %d\n', varargin{1}, varargin{2}, varargin{3});
    end
end

if type == 1
    fprintf(FID,'\ttype %s\n', varargin{1});
end

if calc == 1
    if nargin == 1
        fprintf(FID,'\tcalc\n');
    end
    
    if nargin == 2
        fprintf(FID,'\tcalc %d\n', varargin{1});
    end
    
    if nargin == 3
        fprintf(FID,'\tcalc %d %s\n', varargin{1}, varargin{2});
    end
    
    if nargin == 4
        fprintf(FID,'\tcalc %d %s %d\n', varargin{1}, varargin{2}, varargin{3});
    end
    
    if nargin == 5
        fprintf(FID,'\tcalc %d %s %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
    
    if nargin == 6
        fprintf(FID,'\tcalc %d %s %d %d %s\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
    end
end

fclose(FID);