
// import packages needed
import graph;
usepackage("amsmath");
// Document settings
settings.outformat = "pdf";
picture vso;
size(vso, 9cm, 7cm, IgnoreAspect);
limits(vso, (0, -40), (250, 5));
// Load book typography
defaultpen(fontsize(10pt));
pen gridpen = rgb(0.88, 0.88, 0.88) + 0.4pt;


// Function to compute a smooth spline in normalized (screen-like) space
path normalized_spline(pair[] pts, bool closed=false) {
    // 1. Compute the bounding box
    pair pmin = pts[0], pmax = pts[0];
    for (pair p : pts) {
        pmin = (min(pmin.x, p.x), min(pmin.y, p.y));
        pmax = (max(pmax.x, p.x), max(pmax.y, p.y));
    }
    real dx = pmax.x - pmin.x;
    real dy = pmax.y - pmin.y;
    if (dx == 0) dx = 1;
    if (dy == 0) dy = 1;

    // 2. Normalize to unit square
    guide gn;
    for (pair p : pts) {
        gn = gn .. ((p.x - pmin.x) / dx, (p.y - pmin.y) / dy);
    }
    if (closed) gn = gn .. cycle;

    path pn = gn; // evaluate cubic Bezier control points in isotropic space

    // 3. Transform back to original data coordinates
    transform T = shift(pmin) * scale(dx, dy);
    return T * pn;
}

pair[] data0 = {
(0, 3.09132e-33), (0.124999, -3.89548e-05), (0.28311, -0.000199829), (0.483097, -0.000581867), (0.736042, -0.00135075), (1.05594, -0.0027802), (1.46048, -0.005319), (1.97193, -0.00969844), (2.61834, -0.0171043), (3.43487, -0.0294509), (4.46539, -0.0498156), (5.76415, -0.0831221), (7.39732, -0.137203), (9.44385, -0.224419), (11.9948, -0.36407), (15.1493, -0.585835), (19.0067, -0.934421), (23.8926, -1.18202), (28.7646, -1.36448), (43.3895, -1.88551), (68.2068, -2.78576), (92.9044, -3.77885), (117.297, -4.90297), (140.735, -6.11971), (160.322, -6.94401), (168.991, -6.50056), (173.366, -5.71555), (177.696, -4.78771), (184.778, -3.39309), (196.104, -1.60251), (208.973, -1.28378e-19), (229.679, 2.0342), (239.534, 2.851), (250, 3.64183)};
path smootheddata0 = normalized_spline(data0,false);
draw(vso, smootheddata0, p=red+1.2pt, legend="vso1");
pair[] data0 = {
(0, 2.98127e-32), (0.125, -3.85684e-05), (0.293874, -0.000213175), (0.507481, -0.000635699), (0.777662, -0.00149276), (1.11939, -0.00309288), (1.55158, -0.00594208), (2.09812, -0.0108651), (2.78915, -0.0191993), (3.66262, -0.0331036), (4.76621, -0.0560468), (6.15952, -0.0935746), (7.91661, -0.154495), (10.1285, -0.252677), (12.9055, -0.40968), (16.3782, -0.658443), (20.697, -1.0481), (26.0301, -1.6498), (32.5606, -2.56322), (41.0159, -3.53017), (51.9268, -4.43952), (75.0191, -6.3716), (97.0091, -8.22057), (117.188, -9.91723), (134.812, -11.411), (149.363, -12.7283), (160.635, -14.059), (167.887, -15.5256), (174.116, -17.4624), (181.337, -19.9154), (191.22, -23.0221), (203.752, -26.5819), (218.042, -30.3254), (233.776, -34.2171), (250, -38.0741)};
path smootheddata0 = normalized_spline(data0,false);
draw(vso, smootheddata0, p=black+1.2pt, legend="vso2");
pair[] data0 = {
(0, -1.04905e-31), (0.125, -1.61803e-05), (0.430853, -0.000192231), (0.909274, -0.000856165), (1.51442, -0.002375), (2.27984, -0.00538253), (3.24795, -0.0109246), (4.47234, -0.0207144), (6.02067, -0.0375425), (7.9783, -0.0659334), (10.4527, -0.113195), (13.5787, -0.191085), (17.5249, -0.318456), (22.5002, -0.525386), (28.7602, -0.85958), (36.6115, -1.39602), (46.4094, -2.25096), (58.5416, -3.60101), (73.3896, -5.70594), (91.2557, -8.92981), (113.635, -12.3553), (137.75, -14.8787), (161.835, -17.4198), (185.871, -20.0017), (209.839, -22.6417), (233.727, -25.3535), (250, -27.2537)};
path smootheddata0 = normalized_spline(data0,false);
draw(vso, smootheddata0, p=black+1.2pt, legend="vso3");
pair[] data0 = {
(0, 1.69841e-32), (0.125, -2.78179e-06), (0.5, -4.45084e-05), (1.32206, -0.000311168), (2.53918, -0.00114779), (4.07872, -0.00296128), (6.02606, -0.00646268), (8.48921, -0.0128211), (11.6047, -0.0239434), (15.5453, -0.0429185), (20.529, -0.0747133), (26.8317, -0.127247), (34.801, -0.212993), (44.8746, -0.35125), (57.6007, -0.570956), (73.6567, -0.91313), (93.8551, -1.42963), (118.194, -2.14292), (142.518, -2.65954), (167.258, -2.86933), (191.992, -3.01932), (216.724, -3.10919), (241.456, -3.13537), (250, -3.12887)};
path smootheddata0 = normalized_spline(data0,false);
draw(vso, smootheddata0, p=black+1.2pt, legend="vso4");
xaxis(vso, "Velocity TAS (m/s)", BottomTop,
   LeftTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));
yaxis(vso, "Stability Factor", LeftRight,
   RightTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));

// zero sigma line + dot at flutter
draw(vso, (0,0) -- (250,0), p=black+1.2pt);
pair xing = (209, 0);
dot(vso, xing, black+4pt);

frame f1 = vso.fit();
add(f1);

//------------------------------------------------------------------
// Fuel
//------------------------------------------------------------------
picture fuel;
size(fuel, 9cm, 7cm, IgnoreAspect);
limits(fuel, (0, 150), (100, 300));

pair[] data0 = {
(-3.01507e-19, 300.034), (4.31333, 276.417), (8.46124, 259.083), (12.2928, 246.27), (15.6588, 236.87), (18.5223, 229.94), (20.9082, 224.78), (22.8688, 220.899), (24.4642, 217.952), (25.7536, 215.697), (26.7902, 213.961), (27.6205, 212.616), (28.2836, 211.57), (28.812, 210.754), (29.2324, 210.115), (29.5663, 209.614), (29.816, 209.244), (29.954, 209.04), (30, 208.972), (30.046, 208.905), (30.1841, 208.703), (30.4361, 208.336), (30.7784, 207.844), (31.2134, 207.226), (31.7671, 206.453), (32.4727, 205.487), (33.3738, 204.286), (34.5271, 202.799), (36.0075, 200.969), (37.9144, 198.731), (40.381, 196.021), (43.5877, 192.776), (47.7812, 188.948), (53.3022, 184.515), (60.6241, 179.502), (70.258, 174.078), (79.9474, 169.643), (89.6823, 165.972), (94.565, 164.37), (100, 162.745)};

path smootheddata0 = normalized_spline(data0,false);
draw(fuel, smootheddata0, p=rgb("000000")+1.2pt, legend="fuel1");
xaxis(fuel, "Percent fuel", BottomTop,
   LeftTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));
yaxis(fuel, "Velocity TAS (m/s)", LeftRight,
   RightTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));

// dot at start pt
pair startpt = (30,209);
dot(fuel, startpt, black+4pt);

frame f2 = fuel.fit();
real gap = 1.5cm;
pair offset = (max(f1).x - min(f1).x + gap, min(f1).y - min(f2).y);
// align the bottom of both frames at the same baseline:
add(f2, offset);

// line connecting flutter xing to fuel start
transform t1 = vso.calculateTransform();
transform t2 = fuel.calculateTransform();
pair p1 = t1*xing;
pair p2 = (t2*startpt) + offset;
path connector = p1{dir(0)} .. {dir(-90)} p2;
draw(connector, p=green + 1.0pt + dashed, arrow=Arrow(HookHead,size=6pt));
