function freqReview(SCOM, varargin)
% To transform time domain data into frequency domain data by performing 
% an FFT on specified time histories
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   file - fftfilename
%   time - pad npad (time_phase0) (inc_scale)
%   impd - [curvevolt] [curvecharge] (scalevolt) (scalecharge) (impopt)
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if freq PCOM has already been called 
repeat=0;
FID = fopen('review.revinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'freq';
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

% If first time calling freq print freq PCOM to review file
if repeat==0
    fprintf(FID,'freq\n');
end

% Determine which SCOM selected
file = strcmp (SCOM, 'file');
time = strcmp (SCOM, 'time');
impd = strcmp (SCOM, 'impd');


% Apply selected SCOM to review file
if file == 1
   fprintf(FID,'\tfile %s\n', varargin{1});
end

if time == 1
    pad = strcmp(varargin{1}, 'pad');
    if pad == 1
        if nargin == 3
            fprintf(FID,'\ttime pad %d\n', varargin{2});
        end
        if nargin == 4
            fprintf(FID,'\ttime pad %d %d\n', varargin{2}, varargin{3});
        end
        if nargin == 5
            fprintf(FID,'\ttime pad %d %d %d\n', varargin{2}, varargin{3}, varargin{4});
        end
    end
end

if impd == 1
    if nargin == 5
        fprintf(FID,'\timpd %s %d %s %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
    if nargin == 6
        fprintf(FID,'\timpd %s %d %s %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
    end
    if nargin == 7
        fprintf(FID,'\timpd %s %d %s %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
    end
    if nargin == 8
        fprintf(FID,'\timpd %s %d %s %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7});
    end
end

fclose(FID);
