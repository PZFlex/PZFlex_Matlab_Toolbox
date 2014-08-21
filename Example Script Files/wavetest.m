%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This Matlab script creates and runs a simple wave propagarion model
%   in PZFlex. A pressure load is applied to the left hand boundary of
%   a region containing water
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clear workspace, command window and close all open figure windows
clear;
clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create input variables in Matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Inputs
freqint = 1.0e6;
dist = 30.0e-3;
nelem = 15;
vel = 1496.;
nloops = 10;

% Calculate box size and simulation time
wavelen = vel / freqint;
box = wavelen / nelem;
simtime = dist / vel;

% Define geometry
x = [0 dist];
y = [0 dist];
i = [1 1+round((x(2)-x(1))/box)];
j = [1 1+round((y(2)-y(1))/box)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create and write to PZFlex input file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create PZFlex input file
FID = fopen('pzflex.flxinp','w+');
fclose(FID);

% Read materials file
readOption('wave_test.prjmat');

% Create grid
grd(i(2),j(2));

% Set geometry
geom('xcrd', x(1), x(2), i(1), i(2));

geom('ycrd', y(1), y(2), j(1), j(2));

% Place material
site('regn','watr');

% Define boundary conditions
boun('absr','absr','absr','absr');

% Plot material
grph('plot', 'matr');
term();

% Define excitation function
func('wvlt', freqint, 1);

% Pressure load
plod('pdef', 'pres1', 'func');
plod('vctr','vctr1', 1, 0, 0);
plod('sdef', 'pres1', 'vctr1', i(1)+2, i(1)+2, j(1)+2, j(2)-2); 

% Additional data to be calculated
calc('pres');

% Output time histories
pout('hist', 'func');

% Process model
prcs();

% Get timestep value
getKeyword('tstep', 'timestep');

% Create nexec and nexec2
symb('nexec', '/', simtime, '$tstep');
symb('nexec2', '/', '$nexec', '10');

% Create procedure
proc('save', 'plot');

% Execute model
exec('$nexec2');

% Plot model
grph('plot','pres');

% End procedure
endStatement('proc');

% Run plot process for 12 loops
proc('exec', 'plot', 12);

% End model
stop();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run PZFlex input file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pzflex(64, 's', 'pzflex.flxinp');

