function pcom(SCOM, varargin)                                              % Replace pcom with suitable function name
% Insert description of function
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   SCOM
%                                                                          % Add details of scom(s) and its input parameters
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine if boun PCOM has already been called 
repeat=0;
FID = fopen('pzflex.flxinp');
% Ignore all lines of text, until we see one that just consists of this:
startString = 'pcom';                                                       % Add pcom in lower case
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

% If first time calling boun print boun PCOM to flex file
if repeat==0
    fprintf(FID,'pcom\n');                                                 % Add pcom in lower case
end

% Determine which SCOM selected
scom = strcmp (SCOM, 'scom');                                              % Add scom e.g test = strcmp(SCOM, 'test');

% Apply selected SCOM to flex file
if scom == 1;                                                              % Add scom and write required lines of code.
                                                                           % See other functions for help                                                                       
    fprintf(FID,'\tscom \n');                                              % Add line to print required scom details to flex script
    
end

fclose(FID);