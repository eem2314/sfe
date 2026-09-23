import graph3;
import three;

// Required for math operators and notation
usepackage("amsmath");

settings.outformat = "pdf";
settings.render = 4;

size(11cm, 0);

// Set camera perspective
currentprojection = orthographic(camera=(4.5, -4.0, 2.8), up=(0, 0, 1), target=(0.2, 0.2, 0.4));

// -------------------------------------------------------------
// 1. Coordinate Axes (Parameters k1, k2, and Velocity V)
// -------------------------------------------------------------
real axis_len = 1.6;
triple origin = (-0.4, -0.4, -0.3); // Offset origin so surface sits cleanly in the quadrant

// Draw axes with light/subtle styling so they don't overpower the vectors
draw(origin -- origin + (axis_len, 0, 0), black + 0.7pt, Arrow3(DefaultHead3, size=5.0), L=Label("$k_1$", position=EndPoint, align=S));
draw(origin -- origin + (0, axis_len, 0), black + 0.7pt, Arrow3(DefaultHead3, size=5.0), L=Label("$k_2$", position=EndPoint, align=E));
draw(origin -- origin + (0, 0, axis_len + 0.2), black + 0.7pt, Arrow3(DefaultHead3, size=5.0), L=Label("$\text{Velocity } (V)$", position=EndPoint, align=N));

// -------------------------------------------------------------
// 2. Tilted Solution Manifold: V = f(x, y)
// -------------------------------------------------------------
// A curved hill surface showing V increasing with x and y
triple f(pair t) {
    real z = 0.4 + 0.45*t.x + 0.35*t.y - 0.25*t.x^2 - 0.2*t.y^2;
    return (t.x, t.y, z);
}
surface sol_manifold = surface(f, (-0.3, -0.3), (1.1, 1.1), 16, 16);
draw(sol_manifold, 
     surfacepen=material(rgb(0.86, 0.90, 0.96) + opacity(0.55)), 
     meshpen=rgb(0.68, 0.72, 0.82) + 0.25pt);

// -------------------------------------------------------------
// 3. Current Point x_0 and Tangent Plane null(J)
// -------------------------------------------------------------
// Pick x0 on the surface at (0.3, 0.3)
real x0_x = 0.3, x0_y = 0.3;
real x0_z = 0.4 + 0.45*x0_x + 0.35*x0_y - 0.25*x0_x^2 - 0.2*x0_y^2;
triple x0 = (x0_x, x0_y, x0_z);

dot(x0, p=black + 4.5pt);
label("$\mathbf{x}_j$", x0, align=W);

// Partial derivatives at x0 define the tangent plane: dz = a*dx + b*dy
real a = 0.45 - 2*0.25*x0_x; // dV/dx at x0 = 0.30
real b = 0.35 - 2*0.20*x0_y; // dV/dy at x0 = 0.23

// Tangent vectors spanning the nullspace
triple u_vec = (0.9, 0.0, 0.9 * a);
triple v_vec = (0.0, 0.9, 0.9 * b);
triple corner = x0 - 0.5 * u_vec - 0.5 * v_vec;

// Construct exact 4-point parallelogram for the tangent plane
path3 plane_boundary = corner -- (corner + u_vec) -- (corner + u_vec + v_vec) -- (corner + v_vec) -- cycle;
draw(surface(plane_boundary), surfacepen=material(rgb(0.96, 0.94, 0.82) + opacity(0.5)));
draw(plane_boundary, rgb(0.65, 0.55, 0.25) + 0.6pt + linetype("4 4"));
// label("$\operatorname{null}(J) = \operatorname{span}(Q_2)$", corner + v_vec, align=NW, p=rgb(0.5, 0.4, 0.1));
label("tangent plane", corner + v_vec, align=SW, p=rgb(0.5, 0.4, 0.1));

// -------------------------------------------------------------
// 4. Vectors: w aligned with +V (z-axis), and its projection t_bar
// -------------------------------------------------------------
// w is purely vertical in the V direction: w = (0, 0, |w|)
real w_len = 0.85;
triple w = (0, 0, w_len);

// Surface normal n = (-a, -b, 1), normalized
triple n_unnorm = (-a, -b, 1.0);
real n_mag2 = a*a + b*b + 1.0;

// Orthogonal projection of w onto the tangent plane:
// t_bar = w - ((w . n) / ||n||^2) * n
real dot_wn = w_len; // since w = (0,0,w_len) and n_z = 1
triple proj_drop = (dot_wn / n_mag2) * n_unnorm;
triple t_bar = w - proj_drop;

// Draw unconstrained gradient w (aligned with Velocity axis)
// draw(x0 -- (x0 + w), red + 1.2pt, Arrow3(DefaultHead3, size=6.0), 
//    L=Label("$\mathbf{w} = \nabla V$", align=N, p=red));
draw(x0 -- (x0 + w), red + 1.2pt, Arrow3(DefaultHead3, size=6.0), 
     L=Label("$\mathbf{w}$", align=W, p=red));

// Draw projected continuation tangent t_bar (lies in tangent plane)
//draw(x0 -- (x0 + t_bar), deepblue + 1.5pt, Arrow3(DefaultHead3, size=7.0), 
//     L=Label("$\bar{\mathbf{t}} = Q_2 Q_2^T \mathbf{w}$", align=SE, p=deepblue));
draw(x0 -- (x0 + t_bar), deepblue + 1.5pt, Arrow3(DefaultHead3, size=7.0), 
     L=Label("$\mathbf{t}_j$", align=SE, p=deepblue));

// Draw dashed orthogonal drop line
draw((x0 + w) -- (x0 + t_bar), dashed + gray(0.35) + 0.8pt);

// -------------------------------------------------------------
// 5. Continuation Path along the surface
// -------------------------------------------------------------
// for (real s = -0.4; s <= 0.6; s += 0.05)
guide3 curve_path;
for (real s = -0.4; s >= -2.6; s -= 0.05) {
    real px = x0_x + s * t_bar.x;
    real py = x0_y + s * t_bar.y;
    real pz = 0.4 + 0.45*px + 0.35*py - 0.25*px^2 - 0.2*py^2;
    curve_path = curve_path .. (px, py, pz);
}
draw(curve_path, p=deepgreen + 1.3pt);
// label("Continuation path", point(curve_path, 0.95), align=E, p=deepgreen);
