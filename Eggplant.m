figure('Color','w');
hold on

purple = [159 102 170]/255;
green  = [47 165 80]/255;

% Parameters
bendAmt = 7.0;

zBodyMin = 0.2;
zBodyMax = 9.7;

% Grid
x = -4.2:0.48:9.5;
y = -4.2:0.48:4.2;
z = -0.5:0.48:13;
[X,Y,Z] = meshgrid(x,y,z);

% Body
t = (zBodyMax - Z) ./ (zBodyMax - zBodyMin);
t = max(0,min(1,t));
r_body = 0.55 + 2.15 * max(0, 1 - ((Z-4.7)/5.8).^2);
xshift = bendAmt * t.^1.45;

zJoin = 1.15;
inside_main = (Z >= zJoin) & (Z < zBodyMax) & ...
              (((X - xshift).^2 + Y.^2) < r_body.^2);

% Body End
tJoin = (zBodyMax - zJoin) / (zBodyMax - zBodyMin);
xJoin = bendAmt * tJoin^1.45;
rJoin = 0.55 + 2.15 * max(0, 1 - ((zJoin-4.7)/5.8).^2);

xTip = xJoin + 0.55;
zTip = 0.70;

rxTip = 0.95 * rJoin;
ryTip = 0.95 * rJoin;
rzTip = 1.05;

inside_tip = (((X - xTip).^2)/(rxTip^2) + ...
              (Y.^2)/(ryTip^2) + ...
              ((Z - zTip).^2)/(rzTip^2)) <= 1;

inside_body = inside_main | inside_tip;

% Coneplot
Ub = 0.10 * t;
Vb = zeros(size(X));
Wb = 0.22 * ones(size(X));

h_body = coneplot(X, Y, Z, Ub, Vb, Wb, ...
                  X(inside_body), Y(inside_body), Z(inside_body), 0.78);

set(h_body, 'FaceColor', purple, 'EdgeColor', 'none');

% Stem
zStem = 10.06;
rStem = 0.30;

inside_stem = (abs(Z - zStem) < 0.24) & ...
              (((X - 0).^2 + Y.^2) < rStem^2);

Us = zeros(size(X));
Vs = zeros(size(X));
Ws = 0.18 * ones(size(X));

h_stem = coneplot(X, Y, Z, Us, Vs, Ws, ...
                  X(inside_stem), Y(inside_stem), Z(inside_stem), 0.9);

set(h_stem, 'FaceColor', green, 'EdgeColor', 'none');

% Leaf 
Xl = []; Yl = []; Zl = [];
Ul = []; Vl = []; Wl = [];

leaf_r = 0.22;
leaf_z0 = 10.50;

for k = 1:5
    th = (k-1)*72*pi/180;
    dx = cos(th);
    dy = sin(th);

    for m = 1:4
        f = (m-0.5)/4;

        px = leaf_r*dx + f*1.05*dx;
        py = leaf_r*dy + f*1.05*dy;
        pz = leaf_z0 + f*1.10;

        Xl = [Xl; px];
        Yl = [Yl; py];
        Zl = [Zl; pz];

        Ul = [Ul; 1.20*dx];
        Vl = [Vl; 1.20*dy];
        Wl = [Wl; 0.95];
    end
end

quiver3(Xl, Yl, Zl, Ul, Vl, Wl, 0, ...
    'Color', green, ...
    'LineWidth', 2.2, ...
    'MaxHeadSize', 1.4, ...
    'AutoScale', 'off');

% View
axis equal tight off
view([-28 18])
camlight headlight
lighting gouraud
material dull
title('coneplot Eggplant', 'FontSize', 14)

hold off
