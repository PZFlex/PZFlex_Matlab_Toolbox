function proc(option, varargin)
% To provide the functionality to define, erase and execute procedures.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   OPTION
%   save - procname
%   eras - procname
%   exec - procname (nrepeat)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

% Determine which option selected
save = strcmp (option, 'save');
eras = strcmp (option, 'eras');
exec = strcmp (option, 'exec');

% Apply selected option to flex file
if save == 1
    fprintf(FID,'proc %s save\n', varargin{1});
end

if eras == 1
    fprintf(FID,'proc %s eras\n', varargin{1});
end

if exec == 1
    if nargin == 2
        fprintf(FID,'proc %s\n', varargin{1});
    end

    if nargin == 3
         fprintf(FID,'proc %s %d\n', varargin{1}, varargin{2});
    end
    
end

fclose(FID);

