function rest(SCOM, varargin)
% To restart a job or control the writing of restart files
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   none
%   file restart_input_file
%   writ restart_output_file
%   no file_option
%   yes file_option
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('pzflex.flxinp','a');

if nargin == 0
    fprintf(FID,'rest\n');
else
    % Determine if file or writ selected
    file = strcmp (SCOM, 'file');
    writ = strcmp (SCOM, 'writ');
    no = strcmp (SCOM, 'no');
    yes = strcmp (SCOM, 'yes');
    
    if file == 1
        fprintf(FID, 'rest file %s\n', varargin{1});
    end
    
    if writ == 1
        fprintf(FID, 'rest writ %s\n', varargin{1});
    end
    
    if no == 1
        if nargin == 1
            fprintf(FID, 'rest no\n');
        end
        if nargin == 2
            fprintf(FID, 'rest no %s\n', varargin{1});
        end
    end
    
    if yes == 1
        fprintf(FID, 'rest yes %s\n', varargin{1});
    end
    
end

fclose(FID);