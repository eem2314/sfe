
// import packages needed
import graph;
usepackage("amsmath");
// Document settings
settings.outformat = "pdf";
settings.render = 4;			// XXX ?
// size(25cm, 12cm);	// total figure width
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

// Plot 1: vso

pair[] data0 = {
(0, -3.63146e-38), (0.124999, -4.74598e-05), (0.283109, -0.000243456), (0.483092, -0.000708894), (0.736025, -0.00164559), (1.0559, -0.00338695), (1.46035, -0.00647941), (1.97163, -0.011813), (2.61766, -0.0208298), (3.43336, -0.035855), (4.46211, -0.0606188), (5.75719, -0.10107), (7.38283, -0.166623), (9.41435, -0.272018), (11.9361, -0.439999), (15.036, -0.704955), (18.7956, -1.11752), (23.599, -1.3516), (28.1556, -1.55224), (41.8268, -2.13293), (66.4767, -3.22202), (90.7354, -4.45668), (113.754, -5.87819), (132.463, -7.27365), (140.68, -7.79), (143.393, -7.64444), (145.351, -7.08625), (147.05, -6.37001), (149.744, -5.31424), (154.747, -3.79535), (165.2, -1.56674), (175.112, 4.32781e-19), (193.118, 2.20264), (209.683, 3.81786), (232.509, 5.66003), (250, 6.86188)};

path smootheddata0 = normalized_spline(data0,false);

picture pic1;
size(pic1, 9cm, 7cm, IgnoreAspect);
scale(pic1, Linear, Linear);
draw(pic1, smootheddata0, p=red+1.2pt, legend="vso1");

pair[] data0 = {
(0, 6.07122e-31), (0.125, -4.10289e-05), (0.283111, -0.000210468), (0.483102, -0.000612842), (0.73606, -0.00142263), (1.056, -0.0029281), (1.46062, -0.00560174), (1.97227, -0.0102133), (2.61915, -0.0180102), (3.43671, -0.0310048), (4.46945, -0.0524276), (5.77289, -0.0874363), (7.41581, -0.144206), (9.48237, -0.235569), (12.0738, -0.381386), (15.3087, -0.611797), (19.3224, -0.971371), (24.2636, -1.52395), (30.2934, -2.35794), (38.0414, -3.31362), (46.8331, -4.05146), (69.5184, -5.94831), (90.6401, -7.69065), (109.144, -9.16142), (124.103, -10.2847), (134.653, -11.0712), (141.76, -11.9233), (145.365, -13.4108), (148.299, -15.1028), (152.692, -17.2522), (161.272, -20.6373), (172.2, -24.2674), (185.084, -28.1058), (199.591, -32.1338), (215.412, -36.3266), (232.279, -40.6589), (241.054, -42.8753), (250, -45.1158)};
path smootheddata0 = normalized_spline(data0,false);
draw(pic1, smootheddata0, p=black+0.5pt, legend="vso2");
pair[] data0 = {
(0, 1.0513e-31), (0.125, -1.82429e-05), (0.413197, -0.000199338), (0.850796, -0.000845136), (1.40431, -0.00230251), (2.10441, -0.00517066), (2.98991, -0.0104378), (4.1098, -0.0197221), (5.52598, -0.0356581), (7.3165, -0.0625162), (9.57958, -0.107191), (12.4385, -0.180774), (16.0473, -0.301035), (20.5966, -0.49631), (26.3197, -0.811488), (33.4955, -1.31701), (42.4468, -2.12187), (53.5244, -3.39103), (67.0717, -5.36612), (83.3593, -8.38406), (103.641, -11.8216), (125.456, -14.2083), (149.467, -16.8577), (173.417, -19.5564), (197.282, -22.3277), (221.043, -25.1907), (244.681, -28.1611), (250, -28.848)};
path smootheddata0 = normalized_spline(data0,false);
draw(pic1, smootheddata0, p=black+0.5pt, legend="vso3");
pair[] data0 = {
(0, 4.06527e-39), (0.125, -3.62915e-06), (0.5, -5.80663e-05), (1.31255, -0.000400141), (2.50864, -0.00146164), (4.02157, -0.00375594), (5.93527, -0.00817977), (8.35591, -0.0162078), (11.4178, -0.030247), (15.2907, -0.0542007), (20.1896, -0.0943586), (26.3862, -0.160785), (34.2247, -0.269436), (44.1409, -0.445277), (56.6881, -0.726562), (72.5724, -1.16987), (92.7078, -1.85382), (117.084, -2.82376), (141.498, -3.47996), (166.276, -3.79219), (191.047, -4.02399), (215.812, -4.17088), (240.574, -4.22517), (250, -4.21986)};
path smootheddata0 = normalized_spline(data0,false);
draw(pic1, smootheddata0, p=black+0.5pt, legend="vso4");
pair[] data0 = {
(0, -1.58346e-38), (0.125, -7.74505e-06), (0.5, -0.000123921), (1.25459, -0.000780203), (2.32499, -0.00267946), (3.67892, -0.00670883), (5.39143, -0.0144084), (7.5574, -0.0283112), (10.2967, -0.0525557), (13.7608, -0.0938688), (18.1404, -0.163138), (23.6761, -0.27792), (30.6694, -0.466419), (39.4971, -0.773758), (50.6265, -1.27176), (64.6293, -2.07394), (82.1921, -3.35788), (104.112, -5.39732), (127.961, -8.17385), (151.337, -11.47), (174.965, -14.093), (199.505, -15.8986), (224.054, -17.6894), (236.33, -18.5824), (250, -19.5763)};
path smootheddata0 = normalized_spline(data0,false);
draw(pic1, smootheddata0, p=black+0.5pt, legend="vso5");

// set limits
real xmin = infinity, xmax = -infinity;
for (pair p : data0) {
	xmin = min(xmin, p.x);
	xmax = max(xmax, p.x);
}
xlimits(pic1, 0, 250);
ylimits(pic1, -50, 10);

xaxis(pic1, "Velocity TAS (m/s)", BottomTop,
LeftTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));
yaxis(pic1, "Stability Factor", LeftRight,
RightTicks(Step=0,step=0,extend=false,pTick=gridpen,ptick=nullpen));

// zero sigma line + dot at flutter
draw(pic1, (0,0) -- (250,0), p=black+1.2pt);
pair xing = (175, 0);
dot(pic1, xing, black+4pt);

// ------------------------------------------------------------------
// fuel picture: pic2
// ------------------------------------------------------------------
picture pic2;
size(pic2, 9cm, 7cm, IgnoreAspect);
scale(pic2, Linear, Linear);

pair[] data2 = {
(-3.44702e-20, 296.44), (1.52889, 285.739), (7.5202, 253.961), (14.114, 230.536), (20.4536, 214.463), (26.0931, 203.496), (30.9067, 195.863), (34.9195, 190.422), (38.2158, 186.461), (40.8966, 183.527), (43.0615, 181.324), (44.801, 179.652), (46.1935, 178.372), (47.305, 177.385), (48.1902, 176.62), (48.8943, 176.025), (49.4535, 175.56), (49.8095, 175.268), (49.9524, 175.151), (50, 175.112), (50.0476, 175.074), (50.1905, 174.958), (50.5487, 174.669), (51.1185, 174.216), (51.8429, 173.65), (52.7645, 172.944), (53.9385, 172.069), (55.4368, 170.99), (57.3526, 169.666), (59.8088, 168.058), (62.9669, 166.123), (67.0417, 163.825), (72.3199, 161.141), (79.1871, 158.068), (88.1653, 154.637), (97.9362, 151.506), (100, 150.912)};
path smootheddata2 = normalized_spline(data2,false);
draw(pic2, smootheddata2, p=rgb("000000")+1.2pt, legend="fuel1");

// dot at start pt
pair startpt = (50,175);
dot(pic2, startpt, black+4pt);

// set limits
xlimits(pic2, 0, 100);
ylimits(pic2, 150, 300);
xaxis(pic2, "percent fuel", BottomTop,
	LeftTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));
yaxis(pic2, "Velocity TAS (m/s)", LeftRight,
	RightTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));

frame f1 = pic1.fit();
frame f2 = pic2.fit();

add(f1);
real gap = 1.5cm;
pair offset = (max(f1).x - min(f1).x + gap, min(f1).y - min(f2).y);
// align the bottom of both frames at the same baseline:
add(f2, offset);

// draw a line from the flutter xing to start of fuel variation
// pair p1 = pic1.userToPage(xing);
// pair p2 = pic2.userToPage(startpt);
// pair p1 = scale(pic1).T*xing;
// pair p2 = scale(pic2).T*startpt;
// pair p1 = user_to_frame(pic1,xing);
// pair p2 = user_to_frame(pic2,startpt) + offset;
// pair p1 = pic1.scale.T*xing;
// pair p2 = pic2.scale.T*startpt + offset;
// pair p1 = Scale(pic1,xing);	// works, wrong x
// pair p2 = Scale(pic2,startpt) + offset;
transform t1 = pic1.calculateTransform();
transform t2 = pic2.calculateTransform();
pair p1 = t1*xing;
pair p2 = (t2*startpt) + offset;
path connector = p1{dir(0)} .. {dir(-90)} p2;
draw(connector, p=green + 1.0pt + dashed, arrow=Arrow(HookHead,size=6pt));
