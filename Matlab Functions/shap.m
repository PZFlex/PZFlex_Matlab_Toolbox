function shap(SCOM, varargin)
% To extract steady-state deformation shapes at specified frequencies for 
% regions of the model from a transient time domain analysis
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   data - arrayname
%   freq - frequency
%   node - ibegin iend (jbegin jend) (kbegin kend)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if shap PCOM has already been called 
repeat=0;
FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'shap';
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

% If first time calling shap print shap PCOM to flex file
if repeat==0
    fprintf(FID,'shap\n');
end

% Determine which SCOM selected
data = strcmp (SCOM, 'data');
freq = strcmp (SCOM, 'freq');
node = strcmp (SCOM, 'node');

% Apply selected SCOM to flex file
if data == 1
    fprintf(FID,'\tdata %s\n', varargin{1});    
end

if freq == 1
    fprintf(FID,'\tfreq %d\n', varargin{1});    
end

if node == 1
    if nargin == 3
        fprintf(FID, '\tnode %d %d\n', varargin{1}, varargin{2});
    end
    if nargin == 5
        fprintf(FID, '\tnode %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});  
    end
    if nargin == 7
        fprintf(FID, '\tnode %d %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
    end
end
    
fclose(FID);