function readReview(filename, pathname)
% To define a local file name, associate it with an external file pathname
% and read in all data from the external file
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   filename pathname
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('review.revinp','a');

fprintf(FID,'read %s %s\n', filename, pathname);


fclose(FID);
