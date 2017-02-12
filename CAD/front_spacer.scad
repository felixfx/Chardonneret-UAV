include<common.scad>

m3_nuts_width = 5.7;
m3_nuts_height = 6.4;

thickness = 3;

join_hole_distance = m3_nuts_width * 2;
border_clearance = m3_nuts_height;

width = m3_nuts_width * 4;

arm_join_height = 10;

spacing = 40.6;

support_hole_distance = 3.9;


echo(m3_screw_diameter + support_hole_distance);


difference() {
  
  union() {
  
    translate([-m3_nuts_width*2,0,0])
    cube([width, spacing, thickness]);

    translate([-width/4,-(m3_screw_diameter + support_hole_distance),0])    
    cube([width/2, m3_screw_diameter + support_hole_distance,thickness]);
    
    translate([-width/4,spacing,0])    
    cube([width/2, m3_screw_diameter + support_hole_distance,thickness]);
  }
  
  // Arm join holes
  union () {

    translate([-m3_nuts_width, arm_join_height, 0])     
    cylinder(d=m3_screw_diameter, h=thickness, $fn=100);

    translate([m3_nuts_width, arm_join_height, 0])
    cylinder(d=m3_screw_diameter, h=thickness, $fn=100);
    
    translate([0,-support_hole_distance,0])    
    cylinder(d=m3_screw_diameter, h=thickness, $fn=100);
    
    translate([0,support_hole_distance+spacing,0])    
    cylinder(d=m3_screw_diameter, h=thickness, $fn=100);
    
    translate([0,(spacing+arm_join_height)/2,0])    
    cylinder(d=width-border_clearance*1.5, h=thickness, $fn=100);
  }
}
