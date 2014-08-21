function stopReview()
% To terminate the processing of a job in an orderly manner
%
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('review.revinp','a');

fprintf(FID,'stop\n');

fclose(FID);