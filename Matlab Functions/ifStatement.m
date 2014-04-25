function ifStatement(option, varargin)
% Symbol supports the IF, ELSEIF, ELSE and ENDIF statements in order to 
% provide structured, conditional branching constructs
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   OPTION
%   if     - datum1 op datum 2
%   elseif - datum1 op datum 2
%   else   - none
%   endif  - none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

% Determine which option selected
a = strcmp (option, 'if');
b = strcmp (option, 'elseif');
c = strcmp (option, 'else');
d = strcmp (option, 'endif');

% Apply selected option to flex file
if a == 1;
    fprintf(FID,'if ( %s %s %s ) then\n', varargin{1}, varargin{2}, varargin{3});
end

if b == 1;
    fprintf(FID,'elseif ( %s %s %s ) then\n', varargin{1}, varargin{2}, varargin{3});
end

if c == 1;
    fprintf(FID,'else\n');
end

if d == 1;
    fprintf(FID,'endif\n');
end