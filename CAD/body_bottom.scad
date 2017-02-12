include<common.scad>;

servo_width = 19.8;
servo_depth = 26.8;
server_side_border = 2;
servo_screws_distance = 3.9;
servo_hole_separation = 10;

rpi_width = 65;

electronic_board_width = 80;

boards_clearance = 8;

picam_width = 25;

spacer_width = m3_nut_width * 4;
spacer_thickness = 3;

front_arm_angle = 120/2; // In degrees, between the two arms

spacer_opposite = sin(front_arm_angle) * spacer_width;
spacer_adjacent = cos(front_arm_angle) * spacer_width;

body_lenght = 120;

thickness = 7.4;

half_behind_width = servo_width/2 + server_side_border;

front_width = max(electronic_board_width, rpi_width) + boards_clearance*2 - spacer_adjacent*2;

union() {

difference() {
  
    linear_extrude(thickness)
    polygon([
      [half_behind_width,0],
      
      [rpi_width/2,servo_depth],
      
      [front_width/2+spacer_adjacent,body_lenght-spacer_opposite],
      
      [front_width/2,body_lenght],
      [-front_width/2,body_lenght],
      
      [-front_width/2-spacer_adjacent,body_lenght-spacer_opposite],
      
      [-rpi_width/2,servo_depth],
      
      [-half_behind_width,0]
    ]);
    
  
  // Inside empty space
  border_width = 10;
  linear_extrude(thickness)
  polygon([
    [half_behind_width,servo_depth+border_width/2],
    
    [rpi_width/2-border_width+2,servo_depth+border_width/2],
    
    [front_width/2+spacer_adjacent-border_width,body_lenght-spacer_opposite-border_width],
    
    [front_width/2-border_width,body_lenght-border_width-5],
    [-front_width/2+border_width,body_lenght-border_width-5],
    
    [-front_width/2-spacer_adjacent+border_width,body_lenght-spacer_opposite-border_width],
    
    [-rpi_width/2+border_width-2,servo_depth+border_width/2],
    
    [-half_behind_width,servo_depth+border_width/2]
  ]);

 
    // Arm holder left
  translate([-front_width/2-spacer_adjacent/2, body_lenght-spacer_opposite/2, 0])
  rotate([0,0,front_arm_angle])
  union() {
    translate([0,-spacer_thickness/2,thickness/2])
    cube([spacer_width/2,spacer_thickness,thickness], center=true);
    
    translate([0,spacer_thickness/2,m3_screw_diameter])
    rotate([90,0,0])
    cylinder(d=m3_screw_diameter, h=12, $fn=100);
    
    translate([-m3_nut_width/2,-spacer_thickness-m3_nut_thickness-nut_depth,0])
    cube([m3_nut_width,m3_nut_thickness,thickness]);
  }


  // Arm holder right
  translate([front_width/2+spacer_adjacent/2, body_lenght-spacer_opposite/2, 0])
  rotate([0,0,-front_arm_angle])
  union() {
    translate([0,-spacer_thickness/2,thickness/2])
    cube([spacer_width/2,spacer_thickness,thickness], center=true);
    
    translate([0,spacer_thickness/2,m3_screw_diameter])
    rotate([90,0,0])
    cylinder(d=m3_screw_diameter, h=12, $fn=100);

    translate([-m3_nut_width/2,-spacer_thickness-m3_nut_thickness-nut_depth,0])
    cube([m3_nut_width,m3_nut_thickness,thickness]);
  }
  
  translate([servo_hole_separation/2, 0, thickness-servo_screws_distance])
  union() {
    rotate([-90,0,0])
    cylinder(d=m3_screw_diameter, h=12, $fn=100);
    
    translate([-m3_nut_width/2,nut_depth,(servo_screws_distance-thickness-0.5)])
    cube([m3_nut_width,m3_nut_thickness,thickness+1]);
  }
  
  translate([-servo_hole_separation/2, 0, thickness-servo_screws_distance])
  union() {
    rotate([-90,0,0])
    cylinder(d=m3_screw_diameter, h=12, $fn=100);
    
    translate([-m3_nut_width/2,nut_depth,(servo_screws_distance-thickness-0.5)])
    cube([m3_nut_width,m3_nut_thickness,thickness+1]);
  }
  
  translate([-picam_width/2,body_lenght-spacer_thickness,0]) {
 
    translate([(picam_width-m3_nut_width)/2,-m3_nut_thickness-nut_depth, 0])
    cube([m3_nut_width,m3_nut_thickness,thickness]);
    
    translate([picam_width/2,spacer_thickness,m3_screw_diameter])
    rotate([90,0,0])
    cylinder(d=m3_screw_diameter, h=12, $fn=100);
    
    cube([picam_width,spacer_thickness,thickness]);
  }
  
}

// [Y position, width]
lines_params = [[44, 60], [66, 70], [95, 80]];
line_width = 50;
line_border = 4;

for (p = lines_params) {



  translate ([0,p[0],0]) {
    
    difference() {
      hull () {
        translate([0,0,thickness/2/2])
        cube([p[1],m3_screw_diameter+line_border*2,thickness/2], center=true);
      }
      
      hull () {
        translate([-line_width/2,0,0])
        cylinder(d=m3_screw_diameter, h=thickness/2, $fn=100);
        
        translate([line_width/2,0,0])
        cylinder(d=m3_screw_diameter, h=thickness/2, $fn=100);
      }
    }
  }
  
}

}