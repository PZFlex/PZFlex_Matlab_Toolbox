function readOptionReview(filename)
% The #READ option reads in a file containing any program commands or 
% Symbol statements. It opens the file, reads the input data as if the
% file was a standard input file, and once the eof is found, closes the 
% file and switches back to the previous input file.
%
%%%%%%%%%%%% Input parameters %%%%%%%%%%%%
%
%   filename
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file to write
FID = fopen('review.revinp','a');

fprintf(FID,'symb #read %s\n', filename);

fclose(FID);
