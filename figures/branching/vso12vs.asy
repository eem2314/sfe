
// import packages needed
import graph;
usepackage("amsmath");
// Document settings
settings.outformat = "pdf";
picture vso12vs;
size(vso12vs, 9cm, 7cm, IgnoreAspect);
limits(vso12vs, (0, -30), (250, 6));
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
(0, -3.63146e-38), (0.124999, -4.74598e-05), (0.283109, -0.000243456), (0.483092, -0.000708894), (0.736025, -0.00164559), (1.0559, -0.00338695), (1.46035, -0.00647941), (1.97163, -0.011813), (2.61766, -0.0208298), (3.43336, -0.035855), (4.46211, -0.0606188), (5.75719, -0.10107), (7.38283, -0.166623), (9.41435, -0.272018), (11.9361, -0.439999), (15.036, -0.704955), (18.7956, -1.11752), (23.599, -1.3516), (28.1556, -1.55224), (41.8268, -2.13293), (66.4767, -3.22202), (90.7354, -4.45668), (113.754, -5.87819), (132.463, -7.27365), (140.68, -7.79), (143.393, -7.64444), (145.351, -7.08625), (147.05, -6.37001), (149.744, -5.31424), (154.747, -3.79535), (165.2, -1.56674), (175.112, 4.32781e-19), (193.118, 2.20264), (209.683, 3.81786), (232.509, 5.66003)};
path smootheddata0 = normalized_spline(data0,false);
draw(vso12vs, smootheddata0, p=rgb("000000")+1.2pt, legend="vso121");
pair[] data0 = {
(0, 6.07122e-31), (0.125, -4.10289e-05), (0.283111, -0.000210468), (0.483102, -0.000612842), (0.73606, -0.00142263), (1.056, -0.0029281), (1.46062, -0.00560174), (1.97227, -0.0102133), (2.61915, -0.0180102), (3.43671, -0.0310048), (4.46945, -0.0524276), (5.77289, -0.0874363), (7.41581, -0.144206), (9.48237, -0.235569), (12.0738, -0.381386), (15.3087, -0.611797), (19.3224, -0.971371), (24.2636, -1.52395), (30.2934, -2.35794), (38.0414, -3.31362), (46.8331, -4.05146), (69.5184, -5.94831), (90.6401, -7.69065), (109.144, -9.16142), (124.103, -10.2847), (134.653, -11.0712), (141.76, -11.9233), (145.365, -13.4108), (148.299, -15.1028), (152.692, -17.2522), (161.272, -20.6373), (172.2, -24.2674), (185.084, -28.1058), (199.591, -32.1338), (215.412, -36.3266)};
path smootheddata0 = normalized_spline(data0,false);
draw(vso12vs, smootheddata0, p=rgb("FF0000")+1.2pt, legend="vso122");
xaxis(vso12vs, "Velocity TAS (m/s)", BottomTop,
   LeftTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));
yaxis(vso12vs, "Stability Factor", LeftRight,
   RightTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));
frame vso12vsf = vso12vs.fit();
add(vso12vsf);
