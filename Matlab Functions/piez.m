function piez(SCOM, varargin)
% To allow the option of including piezoelectric materials within 
% the model.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   wndo - ibegin iend (jbegin jend) (kbegin kend)
%   defn - electrodename (areascale)
%   node - ibegin iend (jbegin jend) (kbegin kend)
%   nod2 - mat1 mat2 ibegin iend (jbegin jend) (kbegin kend)
%   bc   - electrodename option (histname)
%   conn - electrodename circuitname sourceoption (histname) (scalehist) (shifthist)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if circ PCOM has already been called 
repeat=0;
FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'piez';
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

% If first time calling piez print piez PCOM to flex file
if repeat==0
    fprintf(FID,'piez\n');
end

% Determine which SCOM selected
wndo = strcmp (SCOM, 'wndo');
defn = strcmp (SCOM, 'defn');
node = strcmp (SCOM, 'node');
nod2 = strcmp (SCOM, 'nod2');
bc = strcmp (SCOM, 'bc');
conn = strcmp (SCOM, 'conn');

% Apply selected SCOM to flex file
if wndo == 1;
    if nargin == 3
        fprintf(FID,'\twndo %d %d\n', varargin{1},varargin{2});
    end
    
    if  nargin == 5
        fprintf(FID,'\twndo %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
    
    if  nargin == 7
        fprintf(FID,'\twndo %d %d %d %d %d %d\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
    end
end

if defn == 1;
    if nargin == 2
        fprintf(FID,'\tdefn %s\n', varargin{1});
    end
    if nargin == 3
        fprintf(FID,'\tdefn %s %d\n', varargin{1}, varargin{2});
    end
end

if node == 1;
    if nargin == 3
        fprintf(FID,'\tnode %d %d\n', varargin{1},varargin{2});
    end
    if nargin == 5
        fprintf(FID,'\tnode %d %d %d %d\n', varargin{1},varargin{2}, varargin{3}, varargin{4});
    end
    if nargin == 7
        fprintf(FID,'\tnode %d %d %d %d %d %d\n', varargin{1},varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
    end
end

if nod2 == 1;
    if  nargin == 5
        fprintf(FID,'\tnod2 %s %s %d %d\n', varargin{1},varargin{2}, varargin{3}, varargin{4});
    end
    if nargin == 7
        fprintf(FID,'\tnod2 %s %s %d %d %d %d\n', varargin{1},varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
    end
    if nargin == 9
        fprintf(FID,'\tnod2 %s %s %d %d %d %d %d %d\n', varargin{1},varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6}, varargin{7}, varargin{8});
    end
end

if bc == 1;
    if nargin == 3
        fprintf(FID,'\tbc %s %s\n', varargin{1},varargin{2});
    end
    if nargin == 4
        fprintf(FID,'\tbc %s %s %s\n', varargin{1},varargin{2}, varargin{3});
    end
end

if conn == 1;
    if nargin == 4
        fprintf(FID,'\tconn %s %s %s\n', varargin{1},varargin{2}, varargin{3});
    end
    if nargin == 5
        fprintf(FID,'\tconn %s %s %s %s\n', varargin{1},varargin{2}, varargin{3}, varargin{4});
    end
    if nargin == 6
        fprintf(FID,'\tconn %s %s %s %s %d\n', varargin{1},varargin{2}, varargin{3}, varargin{4}, varargin{5});
    end
    if nargin == 7
        fprintf(FID,'\tconn %s %s %s %s %d %e\n', varargin{1},varargin{2}, varargin{3}, varargin{4}, varargin{5}, varargin{6});
    end
end

fclose(FID);