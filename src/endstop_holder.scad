

print();
//assembled();

module print(){
translate([0,17,0.7+4.3]) rotate([-90,0,0]) holder();
translate([0,0,0.7+4.3]) rotate([-90,0,0]) holder();
translate([0,-17,0.7+4.3]) rotate([-90,0,0]) holder();
}

module assembled(){
//endstop representation
translate([0,3.25+4+1,5.375-3]) %cube(([19.75,6.5,10.75]),center=true);
//smooth rod representation
%cylinder(r=4,h=30,$fn=30,center=true);
holder();
}

module holder(){
difference(){
//body
translate([0,2.15+0.7,0]) cube(([19.5,4.3,15]),center=true);
//smooth rod
translate([0,0,-1]) cylinder(r=4.1,h=20,$fn=25,center=true);
//fixing holes
translate([4.75,10,0]) rotate([90,0,0]) rotate([0,0,30])  cylinder(r=1.4,h=20,$fn=20);
translate([-4.75,10,0]) rotate([90,0,0]) rotate([0,0,30])  cylinder(r=1.4,h=20,$fn=20);
//fancy edges
translate([10,0,0]) rotate([0,0,45]) cube(([10,6,20]),center=true);
translate([-10,0,0]) rotate([0,0,-45]) cube(([10,6,20]),center=true);
translate([0,0,7.6]) rotate([45,0,0]) cube(([20,10,6]),center=true);
translate([0,0,-7.6]) rotate([-45,0,0]) cube(([20,10,6]),center=true);
translate([8.5,0,8.5]) rotate([0,45,0]) cube(([20,20,6]),center=true);
translate([8.5,0,-8.5]) rotate([0,-45,0]) cube(([20,20,6]),center=true);
translate([-8.5,0,-8.5]) rotate([0,45,0]) cube(([20,20,6]),center=true);
translate([-8.5,0,8.5]) rotate([0,-45,0]) cube(([20,20,6]),center=true);
}
}