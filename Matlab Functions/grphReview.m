function grphReview(SCOM, varargin)
% To provide interactive graphics display of time histories on systems 
% supporting the X11 graphics protocol
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   nvew - nview (type)
%   plot - [curve1] [curve2] . . . [curve6]
%   set  - option parameters
%   pset - option parameters
%   view - iview
%   writ - (options) filename
%   imag - (tiff_filename)
%   eye  - xvalue (yvalue) (zvalue)
%   line - option
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if grphReview PCOM has already been called 
repeat=0;
FID = fopen('review.revinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'grph';
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

% If first time calling grphReview print grphReview PCOM to review file
if repeat==0
    fprintf(FID,'grph\n');
end

% Determine which SCOM selected
nvew = strcmp (SCOM, 'nvew');
plot = strcmp (SCOM, 'plot');
set = strcmp (SCOM, 'set');
pset = strcmp (SCOM, 'pset');
view = strcmp (SCOM, 'view');
writ = strcmp (SCOM, 'writ');
imag = strcmp (SCOM, 'imag');
eye = strcmp (SCOM, 'eye');
line = strcmp (SCOM, 'line');

% Apply selected SCOM to review file
if nvew == 1
    if nargin == 2
        fprintf(FID,'\tnvew %d\n', varargin{1});
    end
    if nargin == 3
        fprintf(FID,'\tnvew %d %d\n', varargin{1}, varargin{2});
    end
end

if plot == 1 
    if nargin == 2
        fprintf(FID,'\tplot %s\n', varargin{1});
    end
    if nargin == 3
        fprintf(FID,'\tplot %s %s\n', varargin{1}, varargin{2});
    end
    if nargin == 4
        fprintf(FID,'\tplot %s %s %s\n', varargin{1}, varargin{2}, varargin{3});
    end
    if nargin == 5
        fprintf(FID,'\tplot %s %s %s %s\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
    if nargin == 6
        fprintf(FID,'\tplot %s %s %s %s %s\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
    end
    if nargin == 7
        fprintf(FID,'\tplot %s %s %s %s %s %s\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
    end
end

if set == 1;
    wndo = strcmp (varargin{1}, 'wndo');
    imag = strcmp (varargin{1}, 'imag');
    
    if wndo == 1
        if nargin == 3
            fprintf(FID,'\tset wndo %s\n', varargin{2});
        end
        if nargin == 4
            fprintf(FID,'\tset wndo %d %d\n', varargin{2}, varargin{3});
        end
        if nargin == 6
            fprintf(FID,'\tset wndo %d %d %d %d\n', varargin{2}, varargin{3}, varargin{4}, varargin{5});
        end
        if nargin == 7
            fprintf(FID,'\tset wndo %d %d %d %d %s\n', varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
        end
    end
    
    if imag == 1
        fprintf(FID,'\tset imag %s\n', varargin{2});
    end
end

if pset == 1;
    wndo = strcmp (varargin{1}, 'wndo');
    
    if wndo == 1
        if nargin == 3
            fprintf(FID,'\tpset wndo %s\n', varargin{2});
        end
        if nargin == 6
            fprintf(FID,'\tpset wndo %d %d %d %d\n', varargin{2}, varargin{3}, varargin{4}, varargin{5});
        end
        if nargin == 7
            fprintf(FID,'\tpset wndo %d %d %d %d %s\n', varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
        end
    end
end


if view == 1
    fprintf(FID,'\tview %d\n', varargin{1});
end

if writ == 1
    if nargin == 2
        fprintf(FID,'\twrit %s\n', varargin{1});
    end
    if nargin == 3
        fprintf(FID,'\twrit %s %s\n', varargin{1}, varargin{2});
    end
    if nargin == 4
        fprintf(FID,'\twrit %s %s %s\n', varargin{1}, varargin{2}, varargin{3});
    end
    if nargin == 5
        fprintf(FID,'\twrit %s %s %s %s\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
end

if imag == 1;
    if nargin == 1
        fprintf(FID,'\timag\n');
    end
    if nargin == 2
        fprintf(FID,'\timag %s\n', varargin{1});
    end
end

if eye == 1
    if nargin == 2
        fprintf(FID,'\teye %d\n', varargin{1});
    end
    if nargin == 3
        fprintf(FID,'\teye %d %d\n', varargin{1}, varargin{2});
    end
    if nargin == 4
        fprintf(FID,'\teye %d %d %d\n', varargin{1}, varargin{2}, varargin{3});
    end
end

if line == 1
    fprintf(FID,'\tline %s\n', varargin{1});
end

fclose(FID);