import graph3;
import three;

// Required for \operatorname and math formatting
usepackage("amsmath");

// Document settings
settings.outformat = "pdf";
settings.render = 4; 

size(10cm, 0);

// Set camera perspective
currentprojection = perspective(camera=(4.5, -3.5, 3.2), up=(0, 0, 1), target=(0, 0, 0.2));

// 1. Solution Manifold: z = -0.3*x^2 + 0.25*y^2
triple f(pair t) {
    return (t.x, t.y, -0.3*t.x^2 + 0.25*t.y^2);
}
pair fprime(pair t) {
	real den = sqrt(0.36t.x^2 + 0.25*t.y^2);
	if (den > 0.0)
		// return ((-0.6*t.x, 0.5*t.y)/den;
		return (-0.6*t.x/den, 0.5*t.y/den);
	else
		return (1.0,0.0);
}
surface sol_manifold = surface(f, (-1.2, -1.2), (1.2, 1.2), 16, 16);
draw(sol_manifold, surfacepen=material(rgb(0.85, 0.88, 0.95) + opacity(0.6)), meshpen=rgb(0.65, 0.7, 0.8) + 0.3pt);

// 2. Point x_0
real x0_x = 0.0;
//!! real x0_y = 0.0;
real x0_y = 0.05;
real x0_z = 0.0;
// triple x0 = (x0_x, x0_y, 0);
pair p = (x0_x, x0_y);
triple x0 = f(p);
dot(x0, p=black + 4pt);
label("$\mathbf{x}_0$", x0, align=SW);

// 3. Tangent plane at x_0 (z = 0)
triple corner = (-0.9, -0.9, 0);
triple u_vec  = (1.8, 0, 0);
triple v_vec  = (0, 1.8, 0);

path3 plane_boundary = corner -- (corner + u_vec) -- (corner + u_vec + v_vec) -- (corner + v_vec) -- cycle;

// Fill the exact parallelogram
draw(surface(plane_boundary), surfacepen=material(rgb(0.95, 0.92, 0.8) + opacity(0.45)));

// Draw the dashed border
draw(plane_boundary, rgb(0.6, 0.5, 0.2) + 0.6pt + linetype("4 4"));
//!! label("$\operatorname{null}(J) = \operatorname{span}(Q_2)$", corner + v_vec, align=NW, p=rgb(0.5, 0.4, 0.1));
label("tangent plane", corner + v_vec/2, align=NW, p=rgb(0.5, 0.4, 0.1));

// 4. Vectors
triple w     = (0.45, 0.55, 1.05);   // Unconstrained gradient
triple t_bar = (-0.20, 0.75, 0.0);    // Projected tangent

draw(x0 -- (x0 + w), red + 1.2pt, Arrow3(DefaultHead3,size=6.0),
		L=Label("$\mathbf{w}$", align=N, p=red));
draw(x0 -- (x0 + t_bar), deepblue + 1.5pt, Arrow3(DefaultHead3,size=7.0),
		L=Label("$\bar{\mathbf{t}}_j$", align=E, p=deepblue));
draw((x0 + w) -- (x0 + t_bar), dashed + gray(0.4) + 0.8pt);

// 5. Continuation path
guide3 curve_path;
pair xj = (x0_x+0.002, x0_y-0.0075);
// for (real s = -0.1; s >= -2.0; s -= 0.05) {
//!! for (int i=1; i<10; ++i) {
//!! 	real s = -0.01*i;
//!! 	pair fp = fprime(xj);
//!!     real px = xj.x + s*fp.x;
//!!     real py = xj.y + s*fp.y;
//!!     // real pz = -0.3*px^2 + 0.25*py^2;
//!! 	 xj = (px,py);
//!!     triple fz = f(xj);
//!!     // curve_path = curve_path .. (px, py, pz);
//!!     curve_path = curve_path .. fz;
//!! }
//!! draw(curve_path, p=deepgreen + 1.2pt);
//!! label("Continuation path", point(curve_path, 0.8), align=SE, p=deepgreen);

// Smoothly interpolates through all four points:
triple p0 = x0;
pair x1 = (x0.x + 0.1, x0.y - 0.2);
triple p1 = f(x1);
pair x2 = (x1.x + 0.2, x1.y);
triple p2 = f(x2);
pair x3 = (x2.x + 0.6, x2.y - 0.2);
triple p3 = f(x3);
triple t_dir = (0.2, -0.75, 0.0);
path3 my_curve = p0{t_dir} .. p1 .. p2 .. p3;
draw(my_curve, deepgreen + 1.2pt);
// dot(p1, red + 3pt);
// dot(p2, red + 3pt);
// dot(p3, red + 3pt);
