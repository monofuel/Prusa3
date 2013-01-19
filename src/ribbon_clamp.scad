/*
1x ribbed clamp is used to secure the ribbon cable and support directly to the Y-carriage, with the remaining 2x clamped together at the other end of the cable to anchor against the ali frame.
*/

//globals
ribbon 		= 	35;			//ribbon cable width
cable_clear	=	1.8;			//gap for cable and support
fixing		= 	ribbon+6;
layer		=	0.2;			//layer height
offset		=	20;			//offset distance for clamp from threaded rod
clearance	=	0.2;			//for fine tuning printer



translate([0,10,0]) clamp();
clamp_nut();
translate([0,-10,0]) clamp();

module clamp(){
difference(){
union(){
//body
translate([-fixing/2,0,0]) cylinder(r=4,h=5,$fn=30);
translate([fixing/2,0,0]) cylinder(r=4,h=5,$fn=30);
translate([0,0,2.5]) cube(([fixing,8,5]),center=true);
}
union(){
//screw holes
translate([-fixing/2,0,-1]) cylinder(r=1.8,h=10,$fn=30);
translate([fixing/2,0,-1]) cylinder(r=1.8,h=10,$fn=30);
//cable
translate([0,0,(5+cable_clear/2)-cable_clear]) cube(([ribbon+clearance,10,cable_clear]),center=true);
}
}
//ribs
translate([0,2.5,5.2-cable_clear]) cube(([ribbon,1,0.4]),center=true);
translate([0,0,5.2-cable_clear]) cube(([ribbon,1,0.4]),center=true);
translate([0,-2.5,5.2-cable_clear]) cube(([ribbon,1,0.4]),center=true);
}



module clamp_nut(){
difference(){
union(){
//body
translate([-fixing/2,0,0]) cylinder(r=4,h=5,$fn=30);
translate([fixing/2,0,0]) cylinder(r=4,h=5,$fn=30);
translate([0,0,2.5]) cube(([fixing,8,5]),center=true);
}
union(){
//screw holes
translate([-fixing/2,0,-1]) cylinder(r=1.8,h=10,$fn=30);
translate([fixing/2,0,-1]) cylinder(r=1.8,h=10,$fn=30);
//nut catchers
translate([-fixing/2,0,-1]) cylinder(r=3.1,h=4,$fn=6);
translate([fixing/2,0,-1]) cylinder(r=3.1,h=4,$fn=6);
}
}
//printable supports
translate([-fixing/2,0,3]) cylinder(r=4,h=layer,$fn=30);
translate([fixing/2,0,3]) cylinder(r=4,h=layer,$fn=30);
}