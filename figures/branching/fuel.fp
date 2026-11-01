# Goland wing from references 1 and 2 section 9.3.
# Aerodynamic center (ac) and center of gravity (cg) variations
# Velocity contours wrt ac and cg
   # define new parameters ac and cg to parameterize the
   # gaf and mass matrices
   parameters{fuel(% fuel)[0:100]=30, alt=2000}

   # Using the default units: meters, Kg
   # Specifying 3 values of ac forces fem to interpolate the aero wrt rf and ac
   # Creates a plugin function, massfcn.cpp, to compute the mass matrix
   # at the current value of cg
   fem{
      nodes{1{0,0,0} : 13{0,6.096,0} },
      material{x{1,0,0}, gj=9.876e+5, eiz=3.0e+7, eix=9.773e+6, ea=2.0e+5},
      beam{1{0}, 2{3:5}, 3:13},
      conmass{noplugin, totalmass=217.74, totalmoi{1,52.68,0}, cg=0.050, orient=x, node{1:13}},
      conmass{noplugin, totalmass=100, totalmoi{1,20,0}, cg=fuel, orient=x, node{1:13}},
      dlm{panels=4, chord=1.83, rf=(0.001,0.1,0.3,2.0), mach=0.5, ac=-0.152},
   }

	pz{i=Mnodal, code=fuelfcn.cpp}

   # Core flutter analysis: should flutter at 175.7 m/s, 10.5 Hz
   flut{
      id=vso,
      indep{vtas[0:250],sigma,freq},
      mass=Mnodal,
      stif=Knodal,
      gaf=Qnodal,
      start{modes=(1:10)},
      target{sigma=0, vtas[10:250]},
   }

   # specify 3 x-y combos with the v option
   viz{id=vso,views{vtas-sigma, vtas-freq, sigma-freq}, nodal.uf}

   # fuel variation
   flut{
      id=fuel, source=vso,
      indep{vtas,freq,fuel},
      start{constant{sigma=0}, vtas[10:250]},
   }
   viz{id=fuel, x=fuel, y=vtas, nodal.uf}

   # vtas contours
   flut{
      id=contour, source=fuel,
      indep{alt, fuel, freq},
      start{constant{vtas{161 : 20 : 400}}},
      sigma=0,
		print{alt,freq, fuel,vtas}
   }
   viz{id{contour,fuel}, x=alt, y=fuel, nodal.uf}

   # alt-fuel-vtas optimization: start pts for contours
   flut{
      id=CO, source=vso,
      indep{alt[-2000:18000], freq[6:10], fuel, vtas[100:400]},
      optimize=vtas,
      start{constant{sigma=0}, vtas[65:300]}
   }

   # vtas contours
   flut{
      id=contour2, source=CO,
      indep{alt, fuel, freq},
      start{constant{vtas{161 : 20 : 400}}},
		sigma=0,
		print{alt,freq, fuel,vtas}
   }
   viz{id{contour2,CO}, x=alt, y=fuel, nodal.uf}
end

freevib.m {{
stif = Knodal;
mass = Mnodal;
[v,d] = eigs(stif,mass,2,0);
roots = sqrt(diag(d))/(2.0*pi);
}}


fuelfcn {{
int fuelfcn (Pset& pset, Mset& mset, ComplexMatrix& ca) {
   vector<Mass> masses {
      {2, 16.7492, {3,1,{0.0769231, 4.05231, 0}},"", 0.05, {3,1,{1, 0, 0}},{6,1,{0, 0, 1, 2, 3, 0}} }
      ,{3, 16.7492, {3,1,{0.0769231, 4.05231, 0}},"", 0.05, {3,1,{1, 0, 0}},{6,1,{0, 0, 4, 5, 6, 0}} }
      ,{4, 16.7492, {3,1,{0.0769231, 4.05231, 0}},"", 0.05, {3,1,{1, 0, 0}},{6,1,{0, 0, 7, 8, 9, 0}} }
      ,{5, 16.7492, {3,1,{0.0769231, 4.05231, 0}},"", 0.05, {3,1,{1, 0, 0}},{6,1,{0, 0, 10, 11, 12, 0}} }
      ,{6, 16.7492, {3,1,{0.0769231, 4.05231, 0}},"", 0.05, {3,1,{1, 0, 0}},{6,1,{0, 0, 13, 14, 15, 0}} }
      ,{7, 16.7492, {3,1,{0.0769231, 4.05231, 0}},"", 0.05, {3,1,{1, 0, 0}},{6,1,{0, 0, 16, 17, 18, 0}} }
      ,{8, 16.7492, {3,1,{0.0769231, 4.05231, 0}},"", 0.05, {3,1,{1, 0, 0}},{6,1,{0, 0, 19, 20, 21, 0}} }
      ,{9, 16.7492, {3,1,{0.0769231, 4.05231, 0}},"", 0.05, {3,1,{1, 0, 0}},{6,1,{0, 0, 22, 23, 24, 0}} }
      ,{10, 16.7492, {3,1,{0.0769231, 4.05231, 0}},"", 0.05, {3,1,{1, 0, 0}},{6,1,{0, 0, 25, 26, 27, 0}} }
      ,{11, 16.7492, {3,1,{0.0769231, 4.05231, 0}},"", 0.05, {3,1,{1, 0, 0}},{6,1,{0, 0, 28, 29, 30, 0}} }
      ,{12, 16.7492, {3,1,{0.0769231, 4.05231, 0}},"", 0.05, {3,1,{1, 0, 0}},{6,1,{0, 0, 31, 32, 33, 0}} }
      ,{13, 16.7492, {3,1,{0.0769231, 4.05231, 0}},"", 0.05, {3,1,{1, 0, 0}},{6,1,{0, 0, 34, 35, 36, 0}} }
      ,{2, 7.69231, {3,1,{0.0769231, 1.53846, 0}},"fuel", 0, {3,1,{1, 0, 0}},{6,1,{0, 0, 1, 2, 3, 0}} }
      ,{3, 7.69231, {3,1,{0.0769231, 1.53846, 0}},"fuel", 0, {3,1,{1, 0, 0}},{6,1,{0, 0, 4, 5, 6, 0}} }
      ,{4, 7.69231, {3,1,{0.0769231, 1.53846, 0}},"fuel", 0, {3,1,{1, 0, 0}},{6,1,{0, 0, 7, 8, 9, 0}} }
      ,{5, 7.69231, {3,1,{0.0769231, 1.53846, 0}},"fuel", 0, {3,1,{1, 0, 0}},{6,1,{0, 0, 10, 11, 12, 0}} }
      ,{6, 7.69231, {3,1,{0.0769231, 1.53846, 0}},"fuel", 0, {3,1,{1, 0, 0}},{6,1,{0, 0, 13, 14, 15, 0}} }
      ,{7, 7.69231, {3,1,{0.0769231, 1.53846, 0}},"fuel", 0, {3,1,{1, 0, 0}},{6,1,{0, 0, 16, 17, 18, 0}} }
      ,{8, 7.69231, {3,1,{0.0769231, 1.53846, 0}},"fuel", 0, {3,1,{1, 0, 0}},{6,1,{0, 0, 19, 20, 21, 0}} }
      ,{9, 7.69231, {3,1,{0.0769231, 1.53846, 0}},"fuel", 0, {3,1,{1, 0, 0}},{6,1,{0, 0, 22, 23, 24, 0}} }
      ,{10, 7.69231, {3,1,{0.0769231, 1.53846, 0}},"fuel", 0, {3,1,{1, 0, 0}},{6,1,{0, 0, 25, 26, 27, 0}} }
      ,{11, 7.69231, {3,1,{0.0769231, 1.53846, 0}},"fuel", 0, {3,1,{1, 0, 0}},{6,1,{0, 0, 28, 29, 30, 0}} }
      ,{12, 7.69231, {3,1,{0.0769231, 1.53846, 0}},"fuel", 0, {3,1,{1, 0, 0}},{6,1,{0, 0, 31, 32, 33, 0}} }
      ,{13, 7.69231, {3,1,{0.0769231, 1.53846, 0}},"fuel", 0, {3,1,{1, 0, 0}},{6,1,{0, 0, 34, 35, 36, 0}} }
   };

	Real fuelcg = 0.5;
	Real fuelval = 100.0;
	// create each (6,6) element mass matrix
	for (auto& me : masses) {
		// get the current value of the cg
		Real cg = me.cg;
		if (!me.cgpar.empty()) {
			pset.parval(me.cgpar, fuelval);
			cg = fuelcg;
		}
		RealMatrix elem{6,6};
		Real fuelpc = fuelval/100.0;
		for (int i=1; i<=3; i++) {
			elem(i,i) = me.mass*fuelpc;
			elem(i+3,i+3) = me.moi(i)*fuelpc;
		}
		// rotation-translation coupling due to cg offset
		for (int j=1; j<=3; j++) {
			matrix<double> prod{3,1,{0,0,0}};
			matrix<double> axis{3,1,{0,0,0}};
			axis(j) = 1.0;
			xprod(axis.data(), me.orient.data(), prod.data());
			for (int i=1; i<=3; i++) {
				elem(i,j+3) += cg*fuelpc*me.mass*prod(i);
				elem(j+3,i) = elem(i,j+3);  // lower-tri
			}
		}
		// moments
		Real t{cg*cg*me.mass*fuelpc};
		elem(4,4) += t*(me.orient(2)*me.orient(2) + me.orient(3)*me.orient(3));
		elem(5,5) += t*(me.orient(1)*me.orient(1) + me.orient(3)*me.orient(3));
		elem(6,6) += t*(me.orient(1)*me.orient(1) + me.orient(2)*me.orient(2));
		// insert into ca
		for (int j=1; j<=6; j++) {
			if (me.rc(j) == 0) continue;
			for (int i=1; i<=6; i++) {
				if (me.rc(i) != 0)
				   ca(me.rc(i),me.rc(j)) += elem(i,j);
			}
		}
	}
   return 0;
}
}}
