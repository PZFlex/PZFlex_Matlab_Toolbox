function grph(SCOM, varargin)
% To provide interactive graphics display of the computational model 
% and results of an analysis.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   arrow - option
%   blok  - blockname [parameters(ibegin iend) (jbegin jend) (kbegin kend)]
%   eye   - xvalue (yvalue) (zvalue)
%   imag  - (tiff_filename)
%   line  - option
%   mirr  - axis option
%   nvew  - nview (type)
%   plot  - matr
%   plot  - datan (blockname)
%   plot  - shap numshape (shapedata) phaseshift
%   plot  - flxhst irecordn
%   set   - option parameters
%   pset  - option parameters
%   vert  - xvalue (yvalue) (zvalue)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if grph PCOM has already been called and if it has if it is the
% last PCOM
repeat=0;
last = 0;

FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'grph';
nextline = char(9);

while 1
    tline = fgetl(FID);
    
    % Break if we hit end of file, or the start marker
    if strcmp(tline, startString)
        repeat=1;
        while 1
            tline = fgetl(FID);
            % Break if we hit end of file, or the start marker
            if tline == -1;
                last = 1;
                break
            end

            if strcmp(tline(1), nextline(1)) == 0
               break
            end
        end
    end
    if ~ischar(tline)
        break
    end
end

% Open file to write
FID = fopen('pzflex.flxinp','a');

% If first time calling grph print grph PCOM to flex file
if repeat==0
    fprintf(FID,'grph\n');
end
% If new PCOM print grph to flex file
if repeat == 1
    if last==0
        fprintf(FID,'grph\n');
    end
end

% Determine which SCOM selected
arrow = strcmp(SCOM, 'arrow');
blok = strcmp (SCOM, 'blok');
eye = strcmp (SCOM, 'eye');
imag = strcmp (SCOM, 'imag');
line = strcmp (SCOM, 'line');
mirr = strcmp (SCOM, 'mirr');
nvew = strcmp (SCOM, 'nvew');
plot = strcmp (SCOM, 'plot');
set = strcmp (SCOM, 'set');
pset = strcmp (SCOM, 'pset');
vert = strcmp(SCOM, 'vert');

% Apply selected SCOM to flex file
if arrow == 1;
    fprintf(FID, '\tarrow %s\n', varargin{1});
end

if blok == 1;
    if nargin == 4
        fprintf(FID,'\tblok %s %d %d\n', varargin{1}, varargin{2}, varargin{3});
    end   
    if nargin == 6
        fprintf(FID,'\tblok %s %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
    end 
    if nargin == 8
        fprintf(FID,'\tblok %s %d %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7});
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

if imag == 1;
    if nargin == 1
        fprintf(FID,'\timag\n');
    end
    if nargin == 2
        fprintf(FID,'\timag %s\n', varargin{1});
    end
end

if line == 1
    fprintf(FID,'\tline %s\n', varargin{1});
end

if mirr == 1;
    fprintf(FID,'\tmirr %s %s\n', varargin{1}, varargin{2});
end

if nvew == 1;
    if nargin == 2
        fprintf(FID,'\tnvew %d\n', varargin{1});
    end
    if nargin == 3
        fprintf(FID,'\tnvew %d %d\n', varargin{1}, varargin{2});
    end
end

if plot == 1;
    matr = strcmp (varargin{1}, 'matr');
    shap = strcmp (varargin{1}, 'shap');
    flxhst = strcmp (varargin{1}, 'flxhst');
    
    if matr == 1
        if nargin == 2
            fprintf(FID, '\tplot matr\n');
        end
        if nargin == 3
            fprintf(FID, '\tplot matr blok %s\n', varargin{2});
        end
    end
    
    if matr == shap == flxhst == 0
        if nargin == 2
            fprintf(FID,'\tplot %s\n', varargin{1});
        end
        if nargin == 3
            fprintf(FID,'\tplot %s blok %s\n', varargin{1}, varargin{2});
        end
    end
    
    if shap == 1
        if nargin == 4
            fprintf(FID, '\tplot shap %d %s\n', varargin{2}, varargin{3});
        end
        if nargin == 5
            fprintf(FID, '\tplot shap %d %d %s\n', varargin{2}, varargin{3}, varargin{4});
        end
    end
    
    if flxhst == 1
        if nargin == 3
            fprintf(FID, '\tplot flxhst %d\n', varargin{2});
        end
    end
    
end

if set == 1;
    wndo = strcmp (varargin{1}, 'wndo');
    imag = strcmp (varargin{1}, 'imag');
    
    if wndo == 1
        if nargin == 3
            fprintf(FID,'\tset wndo %s\n', varargin{2});
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

if vert == 1
    if nargin == 2
        fprintf(FID,'\tvert %d\n', varargin{1});
    end
    if nargin == 3
        fprintf(FID,'\tvert %d %d\n', varargin{1}, varargin{2});
    end
    if nargin == 4
        fprintf(FID,'\tvert %d %d %d\n', varargin{1}, varargin{2}, varargin{3});
    end
end

fclose(FID);
