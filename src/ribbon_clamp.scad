/*
info
*/

//globals
ribbon 	= 	33.5;		//ribbon cable width
fixing	= 	ribbon+5;
layer	=	0.2;			//layer height
offset	=	20;			//offset distance for clamp from threaded rod


//clamp();
translate([0,10,0]) clamp();
bracket();

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
translate([-fixing/2,0,0]) cylinder(r=1.8,h=10,$fn=30);
translate([fixing/2,0,0]) cylinder(r=1.8,h=10,$fn=30);
//screw head holes
translate([-fixing/2,0,-1]) cylinder(r=3.1,h=4,$fn=30);
translate([fixing/2,0,-1]) cylinder(r=3.1,h=4,$fn=30);
//cable
translate([0,0,5]) cube(([ribbon,10,2]),center=true);
}
}
//ribs
translate([0,2.5,0.2+4]) cube(([ribbon,1,0.4]),center=true);
translate([0,0,0.2+4]) cube(([ribbon,1,0.4]),center=true);
translate([0,-2.5,0.2+4]) cube(([ribbon,1,0.4]),center=true);
//printable supports
translate([-fixing/2,0,3]) cylinder(r=4,h=layer,$fn=30);
translate([fixing/2,0,3]) cylinder(r=4,h=layer,$fn=30);
}

module bracket(){
difference(){
union(){
//body
translate([-fixing/2,0,0]) cylinder(r=4,h=5,$fn=30);
translate([fixing/2+offset,0,0]) cylinder(r=4,h=5,$fn=30);
translate([offset/2,0,2.5]) cube(([fixing+offset,8,5]),center=true);
//bar clamp
translate([(fixing/2)+offset/2,4,10]) rotate([90,0,0]) cylinder(r=10,h=8,$fn=30);
}

union(){
//screw holes
//translate([-fixing/2,0,0]) rotate([0,90,0]) #teardrop(r=1.7,h=50,$fn=20);
translate([-fixing/2,0,0]) cylinder(r=1.8,h=10,$fn=30);
translate([fixing/2,0,0]) cylinder(r=1.8,h=10,$fn=30);
translate([fixing/2+offset,0,0]) cylinder(r=1.8,h=10,$fn=30);
//nut catchers
translate([-fixing/2,0,-1]) cylinder(r=3.1,h=4,$fn=6);
translate([fixing/2,0,-1]) cylinder(r=3.1,h=4,$fn=6);
translate([fixing/2+offset,0,-1]) cylinder(r=3.1,h=4,$fn=6);
//bar clamp
translate([(fixing/2)+offset/2,6,10]) rotate([90,0,0]) cylinder(r=5.2,h=12,$fn=30);
}
}
}

module teardrop (r=8,h=20)
{
rotate([-270,0,90])
linear_extrude(height=h)
{
circle(r=r);
polygon(points=[[0,0],[r*cos(30),r*sin(30)],[0.5*r,r],[-0.5*r,r],[-r*cos(30),r*sin(30)]],
paths=[[0,1,2,3,4]]);
}
}

