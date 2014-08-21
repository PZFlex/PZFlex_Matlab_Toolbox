function func(SCOM, varargin)
% To define the characteristics of the special purpose function.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%   hist - histname
%   sine - frequency amplitude (phaseshift) (nperiod) (valuadd)
%   step - amplitude2 steptime amplitude1
%   wvlt - frequency amplitude
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

% Determine which SCOM selected
hist = strcmp (SCOM, 'hist');
sine = strcmp (SCOM, 'sine');
step = strcmp (SCOM, 'step');
wvlt = strcmp (SCOM, 'wvlt');

% Apply selected SCOM to flex file
if hist == 1;
    fprintf(FID, 'func hist %s\n', varargin{1});
end

if sine == 1;
    if nargin == 3
        fprintf(FID,'func sine %f %f\n', varargin{1}, varargin{2});
    end
    if nargin == 4
        fprintf(FID,'func sine %f %f %f\n', varargin{1}, varargin{2}, varargin{3});
    end
    if nargin == 5
        fprintf(FID,'func sine %f %f %f %f\n', varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
    if nargin == 6
        fprintf(FID,'func sine %f %f %f %f %f\n', varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
    end
end

if step == 1;
    fprintf(FID,'func wvlt %f %f %f\n',varargin{1}, varargin{2}, varargin{3});
end

if wvlt == 1;
    fprintf(FID,'func wvlt %f %f\n',varargin{1}, varargin{2});
end

fclose(FID);