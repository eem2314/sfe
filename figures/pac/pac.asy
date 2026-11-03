
// import packages needed
import graph;
usepackage("amsmath");
// Document settings
settings.outformat = "pdf";

picture pac;
size(pac, 9cm, 7cm, IgnoreAspect);
limits(pac, (0, 0), (1, 1));

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

pair p1 = (0.15,0);
pair p2 = (0.5,0.55);
pair p3 = (1,0.65);
dot(pac, p1, red+4pt);
dot(pac, p2, green+4pt);
dot(pac, p3, blue+4pt);
draw(pac, p1 .. p2 .. p3, black+1pt);

draw(pac, (0.2,0.2) -- (0.35,0.65), red+1pt);

// pair[] data0 = {(0,0), (0.5,0.5), (1,0.5)};
// path smootheddata0 = normalized_spline(data0,false);
// draw(pac, smootheddata0, p=rgb("000000")+1.2pt, legend="pac");
xaxis(pac, "X", BottomTop,
    LeftTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));
yaxis(pac, "Y", LeftRight,
    RightTicks(Step=0,step=0,extend=true,pTick=gridpen,ptick=nullpen));
frame f1 = pac.fit();
add(f1);
