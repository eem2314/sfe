
// import packages needed
import graph;
usepackage("amsmath");
// Document settings
settings.outformat = "pdf";
picture vso12so;
size(vso12so, 9cm, 7cm, IgnoreAspect);
limits(vso12so, (-30, 6), (7, 13));
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
(-3.63146e-38, 6.72108), (-4.74598e-05, 6.72107), (-0.000243456, 6.72105), (-0.000708894, 6.72098), (-0.00164559, 6.72086), (-0.00338695, 6.72063), (-0.00647941, 6.72022), (-0.011813, 6.71952), (-0.0208298, 6.71834), (-0.035855, 6.71636), (-0.0606188, 6.71312), (-0.10107, 6.70784), (-0.166623, 6.69935), (-0.272018, 6.68585), (-0.439999, 6.6647), (-0.704955, 6.63227), (-1.11752, 6.58392), (-1.3516, 6.57758), (-1.55224, 6.57985), (-2.13293, 6.61003), (-3.22202, 6.72663), (-4.45668, 6.92811), (-5.87819, 7.25442), (-7.27365, 7.74627), (-7.79, 8.15767), (-7.64444, 8.36541), (-7.08625, 8.51254), (-6.37001, 8.58808), (-5.31424, 8.63831), (-3.79535, 8.66002), (-1.56674, 8.6379), (4.32781e-19, 8.59383), (2.20264, 8.49221), (3.81786, 8.3838), (5.66003, 8.2161), (6.86188, 8.07428)};
path smootheddata0 = normalized_spline(data0,false);
draw(vso12so, smootheddata0, p=rgb("000000")+1.2pt, legend="vso121");
pair[] data0 = {
(6.07122e-31, 12.0728), (-4.10289e-05, 12.0728), (-0.000210468, 12.0728), (-0.000612842, 12.0728), (-0.00142263, 12.0728), (-0.0029281, 12.0727), (-0.00560174, 12.0725), (-0.0102133, 12.0723), (-0.0180102, 12.0719), (-0.0310048, 12.0712), (-0.0524276, 12.0701), (-0.0874363, 12.0683), (-0.144206, 12.0653), (-0.235569, 12.0604), (-0.381386, 12.0527), (-0.611797, 12.0402), (-0.971371, 12.0205), (-1.52395, 11.9893), (-2.35794, 11.94), (-3.31362, 11.8761), (-4.05146, 11.8134), (-5.94831, 11.5912), (-7.69065, 11.2754), (-9.16142, 10.8737), (-10.2847, 10.4094), (-11.0712, 9.93405), (-11.9233, 9.44195), (-13.4108, 9.14677), (-15.1028, 9.03333), (-17.2522, 8.95554), (-20.6373, 8.86707), (-24.2674, 8.77797), (-28.1058, 8.6771), (-32.1338, 8.55902), (-36.3266, 8.42055)};
path smootheddata0 = normalized_spline(data0,false);
draw(vso12so, smootheddata0, p=rgb("FF0000")+1.2pt, legend="vso122");
xaxis(vso12so, "Stability Factor", BottomTop,
   LeftTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));
yaxis(vso12so, "Frequency (Hz)", LeftRight,
   RightTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));
frame vso12sof = vso12so.fit();
add(vso12sof);
