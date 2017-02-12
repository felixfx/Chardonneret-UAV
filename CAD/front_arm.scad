include <common.scad>;

m3_12_l = 12;

hole_border = 2.5;
hole_distance_x = 19;
hole_distance_y = 16;

thickness = 3;

arm_lenght = 170;
arm_top_width = 10;
arm_bottom_width = 20;
arm_heigth = m3_nut_height*6/4;

difference() {
  
union() {
  hull() {
    translate([hole_distance_x/2,0,0]) cylinder(r=m3_screw_diameter/2+hole_border, h=arm_heigth, $fn=100);
    translate([-hole_distance_x/2,0,0]) cylinder(r=m3_screw_diameter/2+hole_border, h=arm_heigth, $fn=100);
    translate([0,hole_distance_y/2,0]) cylinder(r=m3_screw_diameter/2+hole_border, h=arm_heigth, $fn=100);
    translate([0,-hole_distance_y/2,0]) cylinder(r=m3_screw_diameter/2+hole_border, h=arm_heigth, $fn=100);
  };
  
  rotate([90, 0, 0])
  linear_extrude(height=arm_lenght)
  polygon([
    [arm_bottom_width/2, 0],
    [arm_bottom_width/2, 1],
    [arm_top_width/2, arm_heigth],
    [-arm_top_width/2, arm_heigth],
    [-arm_bottom_width/2, 1],
    [-arm_bottom_width/2, 0]
  ]);
  
  translate([0, -arm_lenght - m3_nut_thickness * 3, 0])
  hull() {
    translate([0,20,0])
    rotate([90, 0, 0])
    linear_extrude(height=1)
    polygon([
      [arm_bottom_width/2, 0],
      [arm_bottom_width/2, 1],
      [arm_top_width/2, arm_heigth],
      [-arm_top_width/2, arm_heigth],
      [-arm_bottom_width/2, 1],
      [-arm_bottom_width/2, 0]
    ]);
    
    translate([-m3_nut_width*2, 0, 0])
    cube([m3_nut_width*4, m3_nut_thickness*3, m3_nut_height*6/4]);
  }
  
}

union() {
  
  // Arm join holes
  translate([0, -arm_lenght - m3_nut_thickness * 3, 0])
    union () {
      translate([m3_nut_width/2 , nut_depth, m3_nut_height/4])
      cube([m3_nut_width, m3_nut_thickness, m3_nut_height*2]);
      
      translate([-m3_nut_width - m3_nut_width/2 , nut_depth, m3_nut_height/4])
      cube([m3_nut_width, m3_nut_thickness, m3_nut_height*2]);

      translate([-m3_nut_width, -1, m3_nut_height*3/4])
      rotate([-90,0,0])     
      cylinder(d=m3_screw_diameter, h=m3_12_l, $fn=100);

      translate([m3_nut_width, -1, m3_nut_height*3/4])
      rotate([-90,0,0])     
      cylinder(d=m3_screw_diameter, h=m3_12_l, $fn=100);    
    }

  // Screw holes
  translate([0,0,0]) {
    
    translate([hole_distance_x/2,0,0]) {
      cylinder(d=m3_screw_diameter, h=thickness+2, $fn=100);
      translate([0,0,thickness-m3s_screw_head_height]) cylinder(d1=m3_screw_diameter, d2=m3_screw_head_diameter, h=m3s_screw_head_height, $fn=100);
    }
    
    translate([-hole_distance_x/2,0,0]) {
      cylinder(d=m3_screw_diameter, h=thickness+2, $fn=100);
      translate([0,0,thickness-m3s_screw_head_height]) cylinder(d1=m3_screw_diameter, d2=m3_screw_head_diameter, h=m3s_screw_head_height, $fn=100);
    }
    
    translate([0,hole_distance_y/2,0]) {
      cylinder(d=m3_screw_diameter, h=thickness+2, $fn=100);
      translate([0,0,thickness-m3s_screw_head_height]) cylinder(d1=m3_screw_diameter, d2=m3_screw_head_diameter, h=m3s_screw_head_height, $fn=100);
    }
    
    translate([0,-hole_distance_y/2,0]) {
      cylinder(d=m3_screw_diameter, h=thickness+2, $fn=100);
      translate([0,0,thickness-m3s_screw_head_height]) cylinder(d1=m3_screw_diameter, d2=m3_screw_head_diameter, h=2, $fn=100);
    }
    
    cylinder(d=min(hole_distance_x, hole_distance_y) - m3_screw_diameter - hole_border*2, h=thickness+2, $fn=100);
  }
  
  // All hover
  translate([0,0,thickness])
  hull() {
    translate([hole_distance_x/2,0,0]) cylinder(r=m3_screw_diameter/2+hole_border, h=arm_heigth+2, $fn=100);
    translate([-hole_distance_x/2,0,0]) cylinder(r=m3_screw_diameter/2+hole_border, h=arm_heigth+2, $fn=100);
    translate([0,hole_distance_y/2,0]) cylinder(r=m3_screw_diameter/2+hole_border, h=arm_heigth+2, $fn=100);
    translate([0,-hole_distance_y/2,0]) cylinder(r1=m3_screw_diameter/2+hole_border, r2=15, h=arm_heigth+2, $fn=100);
  };
  
  center_offset = -29;
  translate([0,center_offset, 0])
  union () {
            
    bottom_width = 20;
    top_width = 10;
    seg_lenght = 20;

    arm_out_thickness=2;
    arm_in_thickness=2;
  
    for (d = [0: seg_lenght+arm_in_thickness: center_offset + arm_lenght - seg_lenght - 5]) {

      translate([0,-d,0])
      difference() {
        
        translate([0, seg_lenght/2, 0])
        rotate([90,0,0])
        linear_extrude(seg_lenght)
        polygon(points = [ 
          [-(top_width/2-arm_out_thickness), arm_heigth],
          [top_width/2-arm_out_thickness, arm_heigth],
          [bottom_width/2-arm_out_thickness, 1],
          [bottom_width/2-arm_out_thickness, 0],
          [-(bottom_width/2-arm_out_thickness), 0],
          [-(bottom_width/2-arm_out_thickness), 1]
        ]);


        rotate([0,0,40])
        translate([-arm_in_thickness/2,-seg_lenght,0])
        cube([arm_in_thickness, seg_lenght*2, arm_heigth]);
        
        rotate([0,0,-40])
        translate([-arm_in_thickness/2,-seg_lenght,0])
        cube([arm_in_thickness, seg_lenght*2, arm_heigth]);
        
      }//

    }
    
  }
}
}