function makeReview(SCOM, varargin)
% To provide the capability to use mathematical operations to make new 
% data records (typically time history or frequency domain records) by 
% manipulating previously available records
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   file  - makefilename (option)
%   curve - <mathematical expression defining new curve record>
%   labl  - label
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if makeReview PCOM has already been called 
repeat=0;
FID = fopen('review.revinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'make';
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

% If first time calling makeReview print makeReview PCOM to review file
if repeat==0
    fprintf(FID,'make\n');
end

% Determine which SCOM selected
file = strcmp (SCOM, 'file');
curve = strcmp (SCOM, 'curve');
labl = strcmp (SCOM, 'labl');

% Apply selected SCOM to review file
if file == 1
    if nargin == 2
        fprintf(FID,'\tfile %s\n', varargin{1});
    end
    if nargin == 3
        fprintf(FID,'\tfile %s %s\n', varargin{1}, varargin{2});
    end
end

if curve == 1
    fprintf(FID,'\tcurve %s\n', varargin{1});
end

if labl == 1
    fprintf(FID,'\tlabl %s\n', varargin{1});
end

fclose(FID);
