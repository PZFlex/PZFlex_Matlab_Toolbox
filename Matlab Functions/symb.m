function symb(vname, varargin)
% To define a symb in pzflex input file
%
% Symb can be defined equal to a string
% Or symb can be defined as the addition, subtraction,
% multiplication or division of two strings 
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   vname (value)
%   OR
%   vname operationsign string1 string2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Operation sign must be inputted as string. Either '+', '-', '*' or '/'
% Integers can be inputted as strings. '1', '1.5e-6', etc

% Open file to write
FID = fopen('pzflex.flxinp','a');

% Define symb
if nargin == 1
fprintf(FID,'symb %s\n', vname);
end
% Defines symb as integer
if nargin == 2
fprintf(FID,'symb %s = %d\n', vname, varargin{1});
end

if nargin > 2
    % Defines symb as addition of two strings
    if varargin{1} == '+'
        fprintf(FID,'symb %s = %s + %s\n', vname, varargin{2}, varargin{3});
    end

    % Defines symb as subtraction of two strings
    if varargin{1} == '-'
        fprintf(FID,'symb %s = %s - %s\n', vname, varargin{2}, varargin{3});
    end

    % Defines symb as multiplication of two strings
    if varargin{1} == '*'
        fprintf(FID,'symb %s = %s * %s\n', vname, varargin{2}, varargin{3});
    end

    % Defines symb as division of two strings
    if varargin{1} == '/'
        fprintf(FID,'symb %s = %s / %s \n', vname, varargin{2}, varargin{3});
    end
end

fclose(FID);