
// import packages needed
import graph;
usepackage("amsmath");
// Document settings
settings.outformat = "pdf";

// add to vis
picture vso12vo;
size(vso12vo, 9cm, 7cm, IgnoreAspect);
limits(vso12vo, (0, 6), (250, 13));

// settings.render = 4;			// XXX ?
// size(12cm, 8cm, IgnoreAspect);

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
(0, 6.72108), (0.124999, 6.72107), (0.283109, 6.72105), (0.483092, 6.72098), (0.736025, 6.72086), (1.0559, 6.72063), (1.46035, 6.72022), (1.97163, 6.71952), (2.61766, 6.71834), (3.43336, 6.71636), (4.46211, 6.71312), (5.75719, 6.70784), (7.38283, 6.69935), (9.41435, 6.68585), (11.9361, 6.6647), (15.036, 6.63227), (18.7956, 6.58392), (23.599, 6.57758), (28.1556, 6.57985), (41.8268, 6.61003), (66.4767, 6.72663), (90.7354, 6.92811), (113.754, 7.25442), (132.463, 7.74627), (140.68, 8.15767), (143.393, 8.36541), (145.351, 8.51254), (147.05, 8.58808), (149.744, 8.63831), (154.747, 8.66002), (165.2, 8.6379), (175.112, 8.59383), (193.118, 8.49221), (209.683, 8.3838), (232.509, 8.2161), (250, 8.07428)};
path smootheddata0 = normalized_spline(data0,false);
draw(vso12vo, smootheddata0, p=rgb("000000")+1.2pt, legend="vso121");
pair[] data0 = {
(0, 12.0728), (0.125, 12.0728), (0.283111, 12.0728), (0.483102, 12.0728), (0.73606, 12.0728), (1.056, 12.0727), (1.46062, 12.0725), (1.97227, 12.0723), (2.61915, 12.0719), (3.43671, 12.0712), (4.46945, 12.0701), (5.77289, 12.0683), (7.41581, 12.0653), (9.48237, 12.0604), (12.0738, 12.0527), (15.3087, 12.0402), (19.3224, 12.0205), (24.2636, 11.9893), (30.2934, 11.94), (38.0414, 11.8761), (46.8331, 11.8134), (69.5184, 11.5912), (90.6401, 11.2754), (109.144, 10.8737), (124.103, 10.4094), (134.653, 9.93405), (141.76, 9.44195), (145.365, 9.14677), (148.299, 9.03333), (152.692, 8.95554), (161.272, 8.86707), (172.2, 8.77797), (185.084, 8.6771), (199.591, 8.55902), (215.412, 8.42055), (232.279, 8.25944), (241.054, 8.16956), (250, 8.07336)};
path smootheddata0 = normalized_spline(data0,false);
draw(vso12vo, smootheddata0, p=rgb("FF0000")+1.2pt, legend="vso122");
xaxis(vso12vo, "Velocity TAS (m/s)", BottomTop,
	LeftTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));
yaxis(vso12vo, "Frequency (Hz)", LeftRight,
	RightTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));

frame vso12vof = vso12vo.fit();
add(vso12vof);
