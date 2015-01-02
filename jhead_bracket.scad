/*
Designed by indieflow <indieflow@gmail.com>
This file contains a J-head attachment for use with the new Prusa i3 X-carriage.
My aim was to design a part that was:-
Minimal as possible to reduce the weight on the X-axis, as such reducing noise and strain.
Lock the J-head in tight against the carriage helping to reduce vibration in the hotend.
To incorporate a cooling system for the j-head peek with out blowing on the print (for ABS).
Allow the use of a bowden cable and direct drive via a Nema 17 stepper motor.
*/

/*
requires:
1x j-head mkV 1.75mm filament with 0.5/0.35 nozzle.
1x 4mm OD, 2mm ID pneumatic fitting with m5 thread.
PTFE tube to match fitting.							
25mm 12V DC fan.
2x m3 nuts.
2x m3 washers.
2x m3x 40mm cap screws.
6x self taping screws
2x cable ties
*/

use<x-carriage.scad>

//globals
clearance = 0.2;			//adjust if tight or slack once printed.

//uncomment to view.
//assembly();			//shows components assembled in position.
print();					//places parts in position for exporting as a printable stl.



module clamp(){
difference(){
union(){
translate([0,-0.25,0]) cube(([24,5.5,9]),center=true);
}
union(){
translate([0,8,0]) jhead_cut();
//fixings
//monofuel - increased cylender sizes so that
//screws can slide freely without threading. this piece
//just holds the j-head, and the screws should thread into the main part.
//i also increased the holds to sink the screw heads in easier.
translate([9,0,0]) rotate([90,0,0]) cylinder(r=1.6,h=20,center=true,$fn=20);
translate([-9,0,0]) rotate([90,0,0]) cylinder(r=1.6,h=20,center=true,$fn=20);
translate([9,-6,0]) rotate([90,0,0]) cylinder(r=2.8,h=10,center=true,$fn=20);
translate([-9,-6,0]) rotate([90,0,0]) cylinder(r=2.8,h=10,center=true,$fn=20);
}
}
}

module blank(){
difference(){
union(){
cube(([18,12,1]),center=true);
translate([0,0,-1.25]) cube(([16,12,1.5]),center=true);
}
union(){
translate([0,6,0]) jhead_cut();
}
}
}

module peek_guard(){
difference(){
union(){
//fixing supports
translate([-12,12,0]) rotate([90,0,0]) cylinder(r=4.5,h=24,center=true,$fn=30);
translate([12,12,0]) rotate([90,0,0]) cylinder(r=4.5,h=24,center=true,$fn=30);
difference(){
translate([0,12,0]) cube(([24,24,9]),center=true);
translate([0,31.1,0]) rotate([45,0,0]) cube(([30,10,42]),center=true);}
difference(){
//body
translate([0,12,-18]) cube(([33,24,36]),center=true);
//slanted back
translate([17,26.7,-16]) rotate([0,0,-45]) cube(([30,10,42]),center=true);
translate([-17,26.7,-16]) rotate([0,0,45]) cube(([30,10,42]),center=true);}
}
union(){
//lower corners
translate([16.5,12,-37.6]) rotate([0,-45,0]) cube(([30,26,10]),center=true);
translate([-16.5,12,-37.6]) rotate([0,45,0]) cube(([30,26,10]),center=true);
//fixing holes
//monofuel
//increased hole sizes to allow for easier threading
translate([12,10,0]) rotate([90,0,0]) cylinder(r=1.5,h=60,center=true,$fn=30);
translate([-12,10,0]) rotate([90,0,0]) cylinder(r=1.5,h=60,center=true,$fn=30);
//pneumatic fitting
//monofuel
//increased pneumatic fitting hole to make threading easier, and allow
//the coupling to thread in all the way. i measured the thread on my coupling
//at 8mm. Perhaps the whole part should be scaled up an extra 1mm to get full 8mm?
//set to 7mm atm. close nuff.
translate([0,12,-2]) rotate([90,0,0]) rotate([0,0,90]) teardrop(r=4.8,h=7,$fn=40);
//nut for pneumatic fitting
//monofuel - removing this, because i like threading plastic.
//translate([0,12,-1]) rotate([0,0,30]) cylinder(h=4,r=4.6,$fn=6);
//translate([0,0,1]) cube(([8,24,4]),center=true);
//jhead
translate([0,12,-28]) rotate([0,0,90]) jhead_cut();
translate([0,0,-6.1]) cube(([16+(clearance*2),24,4.75]),center=true);
translate([0,0,-10]) cube(([12.1+(clearance*2),24,7.5]),center=true);
translate([0,0,-28]) cube(([16+(clearance*2),24,30]),center=true);
//side vents
translate([0,12,-23.75]) cube(([25.5,8,13.5]),center=true);
translate([18,12,-23.75]) vent();
translate([-18,12,-23.75]) rotate([0,0,180]) vent();
//fan fixing hole
//monofuel
//increased hole size to play nicely with threading and m3 screws.
//caveat: i don't actually have a fan to use atm, so i don't know
//what screws to use. i'm assuming m3.
//i also shrunk the holes to 8mm depth, assuming that i'm using
//10mm long screws to attach the fan, it should be fine.
translate([0,29,-23.35]) rotate([90,0,0]){
translate([10.15,10.15,10]) cylinder(r=1.5,h=8,center=true,$fn=20);
translate([10.15,-10.15,10]) cylinder(r=1.5,h=8,center=true,$fn=20);
translate([-10.15,-10.15,10]) cylinder(r=1.5,h=8,center=true,$fn=20);
translate([-10.15,10.15,10]) cylinder(r=1.5,h=8,center=true,$fn=20);}
//fan vent
translate([0,20.6,-23.35]) rotate([90,0,0]) cylinder(r1=11.8,r2=5,h=7.2,center=true,$fn=50);    //r2=6 for 40 degree,  r2=5 for 45ish!
//slotted peek section clearance
translate([0,12,-23.75]) cylinder(r=10,h=16.5,center=true,$fn=50);
translate([0,0,-23.75]) cube(([20,24,16.5]),center=true);
//filament
//monofuel
//increased to 1.6 for 3mm filament with some leeway.
// later increased to 1.7 as 1.6 was a bit tight.
translate([0,12,0]) cylinder(r=1.7,h=60,center=true,$fn=20);
//bottom blank
translate([0,6,-34]) cube(([18+(clearance*2),12+(clearance*2),1+(clearance*2)]),center=true);
//clamp
translate([0,2,-10.75]) cube(([24+(clearance*2),11,9+(clearance*2)]),center=true);
translate([0,2,-15]) cube(([20,11,3]),center=true);
//jhead clamp fixings
//monofuel
//increased hole size to make it easier to thread
//decreased depth since we're only using 10mm 3m cap screws
translate([9,7.5,-10.75]) rotate([90,0,0]) cylinder(r=1.5,h=15,center=true,$fn=20);
translate([-9,7.5,-10.75]) rotate([90,0,0]) cylinder(r=1.5,h=15,center=true,$fn=20);
//cableties
translate([16.5,24.25,-8.75]) cabletie();
translate([-16.5,24.25,-8.75]) cabletie();
//translate([0,0,17]) cube(([50,50,50]),center=true);
}
}
}

module jhead(){
//peek
cylinder(r=8,h=30,center=true,$fn=30);
translate([0,0,15+2.25]) cylinder(r=6.05,h=5.5,center=true,$fn=30);
translate([0,0,15+4.5+2.375]) cylinder(r=8,h=4.75,center=true,$fn=30);
//nozzle
translate([3.75,0,-15-4.125]) cube(([12.75,12.75,8.25]),center=true);
}

module jhead_cut(){
//peek
cylinder(r=8+clearance,h=30,center=true,$fn=50);
translate([0,0,15+2.25]) cylinder(r=6.05+clearance,h=5.5,center=true,$fn=50);
translate([0,0,15+4.5+2.375]) cylinder(r=8+clearance,h=4.75+clearance,center=true,$fn=50);	//top clearance equal 0.1 either side at mo, may need adjusting!!!
//nozzle
translate([3.75,0,-15-4.125]) cube(([12.75,12.75,8.25]),center=true);
}

module fan(){
difference(){
union(){
//body
cube(([25.3,25.3,10]),center=true);
}
union(){
//fan
cylinder(r=11.8,h=12,center=true,$fn=30);
//fixings
translate([10.15,10.15,0]) cylinder(r=1.5,h=12,center=true,$fn=20);
translate([10.15,-10.15,0]) cylinder(r=1.5,h=12,center=true,$fn=20);
translate([-10.15,-10.15,0]) cylinder(r=1.5,h=12,center=true,$fn=20);
translate([-10.15,10.15,0]) cylinder(r=1.5,h=12,center=true,$fn=20);
}
}
}

module vent(){
difference(){
union(){
translate([-3,0,0]) rotate([0,0,0]) cube(([5,18,24]),center=true);
}
union(){
translate([0,12.8,0]) rotate([0,0,45]) cube(([20,5,40]),center=true);
translate([0,-12.8,0]) rotate([0,0,-45]) cube(([20,5,40]),center=true);
translate([0,0,-5]) rotate([0,-45,0]) cube(([30,40,5]),center=true);
translate([0,0,15.5]) rotate([0,-45,0]) cube(([30,40,5]),center=true);
translate([-7.8,0,0]) rotate([0,0,0]) cube(([5,10,15]),center=true);
}
}
}

module cabletie(){
difference(){
cylinder(h=3,r=8);
translate([0,0,-0.5]) cylinder(h=4,r=6);
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

module assembly(){
rotate([0,0,180]){
translate([-16.5,0,-24]) rotate([90,0,180]) %x_carriage();}
translate([0,12 ,12]) rotate([180,0,0]) %pneumatic();
peek_guard();
translate([0,12,-28]) rotate([0,0,90]) %jhead();
translate([0,29,-23.35]) rotate([90,0,0]) %fan();
translate([0,6,-34]) blank();
translate([0,4,-10.75]) clamp();
}

module print(){
translate([0,15.75,24]) rotate([-90,0,0]) peek_guard();
translate([0,26,4.5]) clamp();
translate([0,-29,0.5]) rotate([180,0,0]) blank();
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