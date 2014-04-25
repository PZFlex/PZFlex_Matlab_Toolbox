%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This Matlab script creates and runs a simple 2D single element model
%   in PZFlex. A drive function is applied to a ceramic material placed
%   on top of a stainless steel test block
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
freqint = 2e6;
nelem = 20;
vel = 5620;
dist = 30e-3;

% Calculate box size and simulation time
wavelen = vel / freqint;
box = wavelen / nelem;
simtime = dist / vel;

% Model dimensions
pztwidth = 1e-3;
pztheight = 2e-3;
testwidth = dist/2;
testheight = dist;
yspace = 1e-3;

% Model materials
cer_mat = 'fpz26';
test_mat = 'stst';

% Define geometry
x(1) = 0;
x(2) = x(1) + (pztwidth/2);
x(3) = x(2) + (testwidth/2);

y(1) = 0;
y(2) = y(1) + testheight;
y(3) = y(2) + pztheight;
y(4) = y(3) + yspace;

i(1) = 1;
i(2) = i(1) + round((x(2)-x(1))/box);
i(3) = i(2) + round((x(3)-x(2))/box);
indgrd = i(3);

j(1) = 1;
j(2) = j(1) + round((y(2)-y(1))/box);
j(3) = j(2) + round((y(3)-y(2))/box);
j(4) = j(3) + round((y(4)-y(3))/box);
jndgrd = j(4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create and write to PZFlex input file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create PZFlex input file
FID = fopen('pzflex.flxinp','w+');
fclose(FID);

% Read materials file
readOption('general.matr');

% Create Grid
grd(indgrd, jndgrd);

% Set geometry
geom('xcrd', x(1), x(2), i(1), i(2));
geom('xcrd', x(2), x(3), i(2), i(3));

geom('ycrd', y(1), y(2), j(1), j(2));
geom('ycrd', y(2), y(3), j(2), j(3));
geom('ycrd', y(3), y(4), j(3), j(4));

% Place material
site('regn', 'void');
site('regn', cer_mat, i(1), i(2), j(2), j(3));
site('regn', test_mat, i(1), i(3), j(1), j(2));

% Define boundary conditions
boun('side', 'symm', 'absr', 'free', 'free');

% Plot material
grph('mirr', 'x', 'on');
grph('plot', 'matr');
term();

% Define excitation function
func('sine', freqint, 1, 0, 1);

% Additional data to be calculated
calc('pres');
calc('disp');
calc('max', 'pres', 'none', 'mapres');

% Define circuit
circ('defn', 'rdmp');
circ('elem', 'rest', 'sers', 1e9);

ascale = 2;

piez('wndo', i(1), i(3), j(1), j(4));

% generate ground at top of ceramic
piez('defn', 'gnd1', ascale);
piez('nod2', 'void', cer_mat, i(1), i(2), j(3)-1, j(3)+1);

% generate voltage electrodes at bottom of ceramic
piez('defn', 'actv1', ascale);
piez('nod2', cer_mat, 'stst', i(1), i(2), j(2)-1, j(2)+1);

% apply the correct voltage to the predefined electrodes
piez('bc', 'gnd1', 'grnd');
piez('conn', 'actv1', 'rdmp', 'volt', 'func');

% Output time histories
pout('hist', 'func');
pout('histname', 'electrode', 'vq', 'all');

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
grph('mirr', 'x', 'on');
grph('blok', 'B1', i(1), i(3), j(1), j(2));
grph('plot', 'pres', 'B1');

% End procedure
endStatement('proc');

% Run plot process
proc('exec', 'plot', 10);

% End model
stop();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run PZFlex input file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fclose('all');
movefile('pzflex.flxinp', 'single_element_2D.flxinp');
pzflex(64, 's', 'single_element_2D.flxinp');

