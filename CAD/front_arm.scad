m3s_d = 3.4;
m3s_dh = 6;
m3s_hh = 2;

m3n_w = 5.7;
m3n_h = 6.4;
m3n_d = 2.5;

m3_12_l = 12;

hole_border = 2.5;
hole_distance_x = 19;
hole_distance_y = 16;

thickness = 3;

arm_lenght = 170;
arm_top_width = 10;
arm_bottom_width = 20;
arm_heigth = 8;

difference() {
  
union() {
  hull() {
    translate([hole_distance_x/2,0,0]) cylinder(r=m3s_d/2+hole_border, h=arm_heigth, $fn=100);
    translate([-hole_distance_x/2,0,0]) cylinder(r=m3s_d/2+hole_border, h=arm_heigth, $fn=100);
    translate([0,hole_distance_y/2,0]) cylinder(r=m3s_d/2+hole_border, h=arm_heigth, $fn=100);
    translate([0,-hole_distance_y/2,0]) cylinder(r=m3s_d/2+hole_border, h=arm_heigth, $fn=100);
  };
  
  rotate([90, 0, 0])
  linear_extrude(height=arm_lenght)
  polygon([
    [arm_bottom_width/2, 0],
    [arm_top_width/2, arm_heigth],
    [-arm_top_width/2, arm_heigth],
    [-arm_bottom_width/2, 0]
  ], [
  [0,1,2,3]
  ]);
  
  translate([0, -arm_lenght - m3n_d * 3, 0])
  hull() {
    translate([0,20,0])
    rotate([90, 0, 0])
    linear_extrude(height=1)
    polygon([
      [arm_bottom_width/2, 0],
      [arm_top_width/2, arm_heigth],
      [-arm_top_width/2, arm_heigth],
      [-arm_bottom_width/2, 0]
    ], [
    [0,1,2,3]
    ]);
    
    translate([-m3n_w*2, 0, 0])
    cube([m3n_w*4, m3n_d*3, m3n_h*6/4]);
  }
  
}

union() {
  
  // Arm join holes
  translate([0, -arm_lenght - m3n_d * 3, 0])
    union () {
      translate([m3n_w/2 , m3n_d, m3n_h/4])
      cube([m3n_w, m3n_d, m3n_h*2]);
      
      translate([-m3n_w - m3n_w/2 , m3n_d, m3n_h/4])
      cube([m3n_w, m3n_d, m3n_h*2]);

      translate([-m3n_w, -1, m3n_h*3/4])
      rotate([-90,0,0])     
      cylinder(d=m3s_d, h=m3_12_l, $fn=100);

      translate([m3n_w, -1, m3n_h*3/4])
      rotate([-90,0,0])     
      cylinder(d=m3s_d, h=m3_12_l, $fn=100);    
    }

  // Screw holes
  translate([0,0,0]) {
    
    translate([hole_distance_x/2,0,0]) {
      cylinder(d=m3s_d, h=thickness+2, $fn=100);
      translate([0,0,thickness-m3s_hh]) cylinder(d1=m3s_d, d2=m3s_dh, h=m3s_hh, $fn=100);
    }
    
    translate([-hole_distance_x/2,0,0]) {
      cylinder(d=m3s_d, h=thickness+2, $fn=100);
      translate([0,0,thickness-m3s_hh]) cylinder(d1=m3s_d, d2=m3s_dh, h=m3s_hh, $fn=100);
    }
    
    translate([0,hole_distance_y/2,0]) {
      cylinder(d=m3s_d, h=thickness+2, $fn=100);
      translate([0,0,thickness-m3s_hh]) cylinder(d1=m3s_d, d2=m3s_dh, h=m3s_hh, $fn=100);
    }
    
    translate([0,-hole_distance_y/2,0]) {
      cylinder(d=m3s_d, h=thickness+2, $fn=100);
      translate([0,0,thickness-m3s_hh]) cylinder(d1=m3s_d, d2=m3s_dh, h=2, $fn=100);
    }
    
    cylinder(d=min(hole_distance_x, hole_distance_y) - m3s_d - hole_border*2, h=thickness+2, $fn=100);
  }
  
  // All hover
  translate([0,0,thickness])
  hull() {
    translate([hole_distance_x/2+1,0,0]) cylinder(r=m3s_d/2+hole_border, h=arm_heigth+2, $fn=100);
    translate([-hole_distance_x/2-1,0,0]) cylinder(r=m3s_d/2+hole_border, h=arm_heigth+2, $fn=100);
    translate([0,hole_distance_y/2+1,0]) cylinder(r=m3s_d/2+hole_border, h=arm_heigth+2, $fn=100);
    translate([0,-hole_distance_y/2,0]) cylinder(r1=m3s_d/2+hole_border, r2=15, h=arm_heigth+2, $fn=100);
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

      echo(-d);

      translate([0,-d,0])
      difference() {
        
        translate([0, seg_lenght/2, 0])
        rotate([90,0,0])
        linear_extrude(seg_lenght)
        polygon(points = [ 
          [-(top_width/2-arm_out_thickness), arm_heigth],
          [top_width/2-arm_out_thickness, arm_heigth],
          [bottom_width/2-arm_out_thickness, 0],
          [-(bottom_width/2-arm_out_thickness), 0]
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
