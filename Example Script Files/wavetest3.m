%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This Matlab script creates and runs a simple wave propagarion model
%   in PZFlex. A pressure load is applied to all boundaries of a
%   region containing water and two square void regions
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
dist = 25.0e-3;
nelem = 15;
vel = 1496.;
nloops = 10;

% Calculate box size and simulation time
wavelen = vel / freqint;
box = wavelen / nelem;
simtime = dist / vel;

% Define geometry
x = [0 5e-3 10e-3 15e-3 20e-3 dist];
y = [0 5e-3 10e-3 15e-3 20e-3 dist];
i = [1];
j = [1];
for m = 2:6
    i(m) = i(m-1)+round((x(m)-x(m-1))/box);
    j(m) = j(m-1)+round((y(m)-y(m-1))/box);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create and write to PZFlex input file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create PZFlex input file
FID = fopen('pzflex.flxinp','w+');
fclose(FID);

% Read materials file
readOption('wave_test.prjmat');

% Create grid
grd(i(6), j(6));

% Set geometry
geom('xcrd', x(1), x(2), i(1), i(2));
geom('xcrd', x(2), x(3), i(2), i(3));
geom('xcrd', x(3), x(4), i(3), i(4));
geom('xcrd', x(4), x(5), i(4), i(5));
geom('xcrd', x(5), x(6), i(5), i(6));

geom('ycrd', y(1), y(2), j(1), j(2));
geom('ycrd', y(2), y(3), j(2), j(3));
geom('ycrd', y(3), y(4), j(3), j(4));
geom('ycrd', y(4), y(5), j(4), j(5));
geom('ycrd', y(5), y(6), j(5), j(6));

% Place material
site('regn', 'watr');
site('regn', 'void', i(2), i(3),j(2),j(3));
site('regn', 'void', i(4), i(5),j(4),j(5));

% Define boundary conditions
boun('side', 'absr','absr','absr','absr');

% Plot material
grph('plot', 'matr');
term();

% Define excitation function
func('wvlt', freqint, 1);

% Pressure loads
% Left hand side
plod('pdef', 'pres1', 'func');
plod('vctr','vctr1', 1, 0, 0);
plod('sdef', 'pres1', 'vctr1', i(1)+2, i(1)+2, j(1)+2, j(6)-2);
% Right hand side
plod('pdef', 'pres2', 'func');
plod('vctr','vctr2', -1, 0, 0);
plod('sdef', 'pres2', 'vctr2', i(6)-2, i(6)-2, j(1)+2, j(6)-2);
% Bottom
plod('pdef', 'pres3', 'func');
plod('vctr','vctr3', 0, 1, 0);
plod('sdef', 'pres3', 'vctr3', i(1)+2, i(6)-2, j(1)+2, j(1)+2); 
% Top
plod('pdef', 'pres4', 'func');
plod('vctr','vctr4', 0, -1, 0);
plod('sdef', 'pres4', 'vctr4', i(1)+2, i(6)-2, j(6)-2, j(6)-2);

% Additional data to be calculated
calc('pres');

% Output time histories
pout('hist', 'func');

% Process model
prcs();

% Calculate number of steps
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

