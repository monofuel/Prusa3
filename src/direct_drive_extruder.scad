/*
Designed by indieflow <indieflow@gmail.com>
Direct drive extruder for use with a nema 17 stepper motor and makerbot mk7 drive gear. 
The extruder is designed to use a bowden cable system for 1.75mm filament.
Can be mounted directly on the frame of the new Prusa i3.
The face of the extruder is left open for easy cleaning of the drive gear.
Ajustment of the idler spring tension is achieved by tightening the 4x long m3 screws which are positioned along with the springs and washers at the front of the extruder.
625 bearing on the top of the extruder is for stepper shaft support (not a requirement if no bearings available).
*/

/*
requires:
4x m3 nuts.
8x m3 washers
5x m3x10mm cap screws.
2x m3x14mm cap screws.
4x m3x40mm cap screws.
1x 4mmx12mm round bar or threaded bar. 	//Cut a m4 bolt to size.
1x 4mm OD, 2mm ID pneumatic fitting with m5 thread.
1x mk7 drive gear.
1x 624 bearing.							//idler bearing.
1x 625 bearing.							//used for motor shaft support, can be used without.
4x springs.

Jobs to do:
Assess the fit of the bearing in the idler and main block.
*/

//globals
clearance 	= 0.2;			//adjust if tight or slack once printed.
layer_height	= 0.3;			//used for removable structure.

//uncomment to view.
assembled();				//shows components assembled in position.
//printable();					//places parts in position for exporting as a printable stl.



module printable(){
translate([6,-12,10]) rotate([-90,0,0]) extruder();
translate([26.5,0,0]) rotate([0,0,0]) idler();
translate([20,23,0]) rotate([0,-90,0]) extruder_holder();
//motor bridge supports
translate([0,0,7.25]) cube(([18,2,14.5]),center=true);
translate([0,0,(layer_height/2)+2.2]) cube(([18,25,layer_height]),center=true);
translate([0,0,(layer_height/2)+14.5]) cube(([18,14,layer_height]),center=true);
//idler fixing blanks
translate([35.5,4,2.15]) cylinder(r=2,h=layer_height,center=true,$fn=20);
translate([35.5,-4,2.15]) cylinder(r=2,h=layer_height,center=true,$fn=20);
translate([17.5,-4,2.15]) cylinder(r=2,h=layer_height,center=true,$fn=20);
translate([17.5,4,2.15]) cylinder(r=2,h=layer_height,center=true,$fn=20);
}

module assembled(){
translate([6,-12,57]) rotate([-90,0,0]){
extruder();
translate([13.5,0,12]) rotate([0,-90,0]) idler();
translate([-5.9,33.5,12]) %nema17();
translate([-5.9,2,12]) rotate([90,0,0]) %drive_gear();
translate([-5.9,-8.5,12]) rotate([90,0,0]) %625_bearing();			//drive bearing
translate([7,0,12]) rotate([90,0,0]) %624_bearing();				//idler bearing
translate([0,0,10]) #cylinder(r=0.875,h=60,center=true,$fn=20);	//filament
translate([0,0,35.9]) rotate([0,180,0]) %pneumatic();
}
translate([29,-20,56]) rotate([180,0,0]) rotate([0,0,180]) extruder_holder();
}

module extruder(){
difference(){
union(){
difference(){
//extruder body
translate([-6,-0.5,12]) cube(([18,21,24]),center=true);
//idler bearing cut out
translate([6.5,3,12]) rotate([90,0,0]) cylinder(r=7,h=15,center=true,$fn=30);
//drive gear cleaning access
translate([-15.9,3,12]) cube(([20,15,13.5]),center=true);}
//motor supports
translate([-6,5,26.5]) cube(([30,10,4]),center=true);
translate([-6,-0.5,26.25]) cube(([18,21,4.5]),center=true);
translate([-6,5,-2.5]) cube(([30,10,4]),center=true);
translate([-6,-0.5,-2.25]) cube(([18,21,4.5]),center=true);
translate([3,0,-2.5]) rotate([0,0,45]) cube(([10,5,4]),center=true);
translate([-15,0,-2.5]) rotate([0,0,-45]) cube(([10,5,4]),center=true);
translate([3,0,26.5]) rotate([0,0,45]) cube(([10,5,4]),center=true);
translate([-15,0,26.5]) rotate([0,0,-45]) cube(([10,5,4]),center=true);
translate([5,9,12]) cube(([4,5,30]),center=true);
translate([-17,9,12]) cube(([4,5,30]),center=true);
//motor fixing points
translate([9.6,7.5,27.5]) rotate([90,0,0]) cylinder(r=5,h=5,center=true,$fn=30);
translate([9.6,7.5,-3.5]) rotate([90,0,0]) cylinder(r=5,h=5,center=true,$fn=30);
translate([-21.4,5,27.5]) rotate([90,0,0]) cylinder(r=5,h=10,center=true,$fn=30);
translate([-21.4,5,-3.5]) rotate([90,0,0]) cylinder(r=5,h=10,center=true,$fn=30);
}
union(){
//nema 17 cutout
translate([-5.9,33.5,12]) nema17_cut();
//bracket clearance
translate([8,0,27]) cube(([5,10,6]),center=true);
translate([8,0,-3]) cube(([5,10,6]),center=true);
//motor fixing head clearance
translate([-21.4,-6,-3.5]) rotate([90,0,0]) cylinder(r=2.8,h=20,center=true,$fn=20);
translate([-21.4,-6,27.5]) rotate([90,0,0]) cylinder(r=2.8,h=20,center=true,$fn=20); 
//drive gear cut out
translate([-5.9,3,12]) rotate([90,0,0]) cylinder(r=6.75,h=15,center=true,$fn=30);
//drive shaft cutout
translate([-5.9,0,12]) rotate([90,0,0]) cylinder(r=3,h=22,center=true,$fn=30);
//drive shaft support bearing cutout
translate([-5.9,-8.5,12]) rotate([90,0,0]) cylinder(r=5,h=6,center=true,$fn=30);
translate([-5.9,-9,12]) rotate([90,0,0]) cylinder(r=8+clearance,h=6,center=true,$fn=30);
//idler fixings
translate([-25,4,21]) rotate([90,0,0]) teardrop(r=1.7,h=50,$fn=20);
translate([-25,-4,21]) rotate([90,0,0]) teardrop(r=1.7,h=50,$fn=20);
translate([-25,-4,3]) rotate([90,0,0]) teardrop(r=1.7,h=50,$fn=20);
translate([-25,4,3]) rotate([90,0,0]) teardrop(r=1.7,h=50,$fn=20);
//idler path
translate([11,-2.65,12]) idler_cut();
translate([-23,-2.65,12]) idler_cut();
//filament path
translate([0,0,-20]) rotate([90,0,0]) rotate([0,0,90]) teardrop(r=1.1,h=60,$fn=20);
translate([0,-0.6,9.2]) rotate([45,0,0]) cube(([16,2,2]),center=true);
translate([0,-0.6,14.8]) rotate([45,0,0]) cube(([16,2,2]),center=true);
//pneumatic fitting
translate([0,0,24.25]) rotate([90,0,0]) rotate([0,0,90]) teardrop(r=2.35,h=5,$fn=20);
//fancy top
translate([-6,-17,-0.5]) rotate([45,0,0]) cube(([21,10,50]),center=true);
translate([-5,-17,24.5]) rotate([-45,0,0]) cube(([50,10,50]),center=true);
}
}
}

module idler_block(){
difference(){
minkowski(){
translate([0,0,4.5]) cube(([18.5,9,9]),center=true);
cylinder(r=3,h=1,$fn=30);}
//idler bearing cut out
translate([0,0,6.5]) rotate([90,0,0]) cylinder(r=7.5,h=7,center=true,$fn=30);}
//bearing guides
translate([0,3,6.5]) rotate([90,0,0]) cylinder(r1=4.3,r2=3.3,h=1,center=true,$fn=30);
translate([0,-3,6.5]) rotate([-90,0,0]) cylinder(r1=4.3,r2=3.3,h=1,center=true,$fn=30);
}

module idler_fixings(){
//shaft
translate([0,0,6.5]) rotate([90,0,0]) cylinder(r=2,h=12,center=true,$fn=30);
translate([0,0,9.5]) cube(([4,12,6]),center=true);
//fixings
translate([9,4,24]) cylinder(r=1.7,h=50,center=true,$fn=20);
translate([9,-4,24]) cylinder(r=1.7,h=50,center=true,$fn=20);
translate([-9,-4,24]) cylinder(r=1.7,h=50,center=true,$fn=20);
translate([-9,4,24]) cylinder(r=1.7,h=50,center=true,$fn=20);
//nut traps
translate([9,4,-1]) rotate([0,0,30]) cylinder(r=3.1,h=3,$fn=6);
translate([9,-4,-1]) rotate([0,0,30]) cylinder(r=3.1,h=3,$fn=6);
translate([-9,-4,-1]) rotate([0,0,30]) cylinder(r=3.1,h=3,$fn=6);
translate([-9,4,-1]) rotate([0,0,30]) cylinder(r=3.1,h=3,$fn=6);
}

module idler(){
difference(){
idler_block();
idler_fixings();
}
translate([0,0,6.5]) rotate([90,0,0]) %624_bearing();
translate([0,0,6.5]) rotate([90,0,0]) %cylinder(r=2,h=12,center=true,$fn=30);
}

module idler_cut(){
difference(){
cube(([16,21,25]),center=true);
translate([0,11,14.5]) rotate([-45,0,0]) cube(([20,10,5]),center=true);
translate([0,11,-14.5]) rotate([45,0,0]) cube(([20,10,5]),center=true);}
}

module nema17(){
rotate([-90,0,0]){
translate([0,0,0]) cube([42,42,47],center=true);
//flange
translate ([0,0,-24]) cylinder(r=11,h=3,center=true,$fn=30);
//shaft
translate ([0,0,-36]) cylinder(r=2.5,h=23,center=true,$fn=20);
}
}

module nema17_cut(){
rotate([-90,0,0]){
translate([0,0,0]) cube([42+(clearance*2),42+(clearance*2),47],center=true);
//flange
translate ([0,0,-24-(clearance/2)]) cylinder(r=11+clearance,h=3+clearance,center=true,$fn=30);
//shaft
translate ([0,0,-36-(clearance/2)]) cylinder(r=2.5+clearance,h=23+clearance,center=true,$fn=20);
//fixings
translate([15.5,15.5,-36]) cylinder(r=1.7,h=30,center=true,$fn=20);
translate([15.5,-15.5,-36]) cylinder(r=1.7,h=30,center=true,$fn=20);
translate([-15.5,-15.5,-36]) cylinder(r=1.7,h=30,center=true,$fn=20);
translate([-15.5,15.5,-36]) cylinder(r=1.7,h=30,center=true,$fn=20);
}
}

module gear(){
difference(){
union(){
cylinder(r=6.3,h=11,center=true,$fn=30);
}
union(){
translate([0,0,0]) cylinder(r=2.6,h=13,center=true,$fn=30);
translate([0,4,-2.5]) rotate([90,0,0]) cylinder(r=1.5,h=6,center=true,$fn=30);
translate([0,0,2]) rotate_extrude(convexity=10,$fn=100)
translate([7.3,0,0])
circle(r=2,$fn=100);
}
}
}


module bearing_slot(){
difference(){ 
cylinder(r=6.5,h=4.25,center=true,$fn=30);
cylinder(r=5.9,h=5.25,center=true,$fn=30);
}
}

module drive_gear(){
difference(){
gear();
translate([0,0,2]) bearing_slot();
}
}

module 624_bearing(){
difference(){
cylinder(r=6.5,h=5,center=true,$fn=30);
cylinder(r=2,h=6,center=true,$fn=30);
}
}

module 625_bearing(){
difference(){
cylinder(r=8,h=5,center=true,$fn=30);
cylinder(r=2.5,h=6,center=true,$fn=30);
}
}

module bracket_fancy(){
//corner cutouts
translate([0.5,0.5,0]) rotate([0,0,-45-180]) translate([-15,0,-1]) cube([30,30,51]);
translate([0.5,40-0.5,0]) rotate([0,0,-45+90]) translate([-15,0,-1]) cube([30,30,51]);
translate([8,0,12+20+3]) rotate([0,-55,0]) translate([0,-5,0]) cube([30,50,30]);
translate([8,0,12+10]) rotate([45,0,0]) rotate([0,-90,0]) translate([0,-5,0]) cube([30,50,30]);
translate([8,20,12+30]) rotate([-45,0,0]) rotate([0,-90,0]) translate([0,-5,0]) cube([30,50,30]);
translate([0,20,-2.8]) rotate([0,45,0]) cube(([10,45,4]),center=true);
difference(){
translate([0,20,5]) rotate([45,0,0]) cube(([17.7,17.7,17.7]),center=true);
translate([0,20,18]) cube(([20,10,5]),center=true);}
translate([0,20,0]) cube(([17,25,10]),center=true);
}

module bracket_holes(){
//Frame mounting screw holes
translate([-1,10,10+5]) rotate([0,90,0]) cylinder(r=1.7,h=20,$fn=30);
translate([-1,10+20,10+5]) rotate([0,90,0]) cylinder(r=1.7,h=20,$fn=30);
translate([-1,10+10,10+20+5]) rotate([0,90,0]) cylinder(r=1.7,h=20,$fn=30);
//Frame mounting screw head holes
translate([4,10,10+5]) rotate([0,90,0]) cylinder(r=3.1,h=20,$fn=30);
translate([4,10+20,10+5]) rotate([0,90,0]) cylinder(r=3.1,h=20,$fn=30);
translate([4,10+10,10+20+5]) rotate([0,90,0]) cylinder(h = 20, r=3.1, $fn=30);
translate([4,10+10-3.1,10+20+5]) cube([10,6.2,10]);
//extruder attachment holes
translate([13.4,4.5,6]) rotate([0,90,0]) teardrop(r=1.7,h=20,$fn=30);
translate([13.4,35.5,6]) rotate([0,90,0]) teardrop(r=1.7,h=20,$fn=30);
}

module extruder_holder(){
difference(){
union(){
translate([13.4,3.75,-1]) cylinder(r=3.75,h=5,$fn=20);
translate([13.4,36.25,-1]) cylinder(r=3.75,h=5,$fn=20);
translate([3,0,-1]) cube([10,7.5,5]);
translate([3,32.5,-1]) cube([10,7.5,5]);
translate([0,0,-1]) cube([8,40,16+28]);
translate([7.15,3.5,-1]) cube([10,4,5]);
translate([7.15,32.5,-1]) cube([10,4,5]);}
bracket_fancy();
bracket_holes();
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

module pneumatic(){
difference(){
union(){
cylinder(r=4.5,h=14.5,center=true,$fn=30);
translate([0,0,4]) cylinder(r=2.5,h=14.5,center=true,$fn=30);
}
union(){
translate([0,0,-5]) cylinder(r=2,h=14.5,center=true,$fn=20);
translate([0,0,5]) cylinder(r=1,h=14.5,center=true,$fn=20);
}
}
}