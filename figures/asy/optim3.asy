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
surface sol_manifold = surface(f, (-1.2, -1.2), (1.2, 1.2), 16, 16);
draw(sol_manifold, surfacepen=material(rgb(0.85, 0.88, 0.95) + opacity(0.6)), meshpen=rgb(0.65, 0.7, 0.8) + 0.3pt);

// 2. Point x_0
triple x0 = (0, 0, 0);
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
label("$\operatorname{null}(J) = \operatorname{span}(Q_2)$", corner + v_vec, align=NW, p=rgb(0.5, 0.4, 0.1));

// 4. Vectors
triple w     = (0.45, 0.55, 1.05);   // Unconstrained gradient
triple t_bar = (0.45, 0.55, 0.0);    // Projected tangent

draw(x0 -- (x0 + w), red + 1.2pt, Arrow3(), L=Label("$\mathbf{w}$", align=N, p=red));
draw(x0 -- (x0 + t_bar), deepblue + 1.5pt, Arrow3(), L=Label("$\bar{\mathbf{t}} = Q_2 Q_2^T \mathbf{w}$", align=E, p=deepblue));
draw((x0 + w) -- (x0 + t_bar), dashed + gray(0.4) + 0.8pt);

// 5. Continuation path
guide3 curve_path;
for (real s = -0.6; s <= 0.9; s += 0.05) {
    real px = s * 0.45;
    real py = s * 0.55;
    real pz = -0.3*px^2 + 0.25*py^2;
    curve_path = curve_path .. (px, py, pz);
}
draw(curve_path, p=deepgreen + 1.2pt);
label("Continuation path", point(curve_path, 0.8), align=SE, p=deepgreen);
