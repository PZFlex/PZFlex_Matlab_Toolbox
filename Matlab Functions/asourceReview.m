function asourceReview(SCOM, varargin)
% To generate approximate acoustic sources from simple geometries such 
% that pressure can be extrapolated to target points surrounding the
% source
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   fluid      - density wavespeed
%   file       - filename
%   ref        - (xref) (yref) (zref) refoption
%   resolution - freqmax (nstcyc) (delx)
%   rect       - axisname xmin xmax ymin ymax drivename scale timeshift
%   run        - pulse_length
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if asource PCOM has already been called 
repeat=0;
FID = fopen('review.revinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'asource';
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

% If first time calling asource print asource PCOM to review file
if repeat==0
    fprintf(FID,'asource\n');
end

% Determine which SCOM selected
fluid = strcmp (SCOM, 'fluid');
file = strcmp (SCOM, 'file');
ref = strcmp (SCOM, 'ref');
resolution = strcmp (SCOM, 'resolution');
rect = strcmp (SCOM, 'rect');
run = strcmp (SCOM, 'run');

% Apply selected SCOM to review file
if fluid == 1
    fprintf(FID,'\tfluid %d %d\n', varargin{1}, varargin{2});  
end

if file == 1
    fprintf(FID,'\tfile %s\n', varargin{1});   
end

if ref == 1
    if nargin == 2
        fprintf(FID,'\tref %s\n', varargin{1});
    end
    if nargin == 3
        fprintf(FID,'\tref %f %s\n', varargin{1}, varargin{2});
    end
    if nargin == 4
        fprintf(FID,'\tref %f %f %s\n', varargin{1}, varargin{2}, varargin{3});
    end
    if nargin == 5
        fprintf(FID,'\tref %f %f %f %s\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end    
end

if resolution == 1
    if nargin == 2
        fprintf(FID,'\tresolution %f\n', varargin{1});
    end
    if nargin == 3
        fprintf(FID,'\tresolution %f %f\n', varargin{1}, varargin{2});
    end  
    if nargin == 4
        fprintf(FID,'\tresolution %f %f %f\n', varargin{1}, varargin{2}, varargin{3});
    end 
end

if rect == 1
    fprintf(FID,'\trect %s %d %d %d %d %s %s %s\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7}, varargin{8});    
end
if run == 1
    fprintf(FID,'\trun %f\n', varargin{1});   
end

fclose(FID);