

servo_width = 19.8;
servo_depth = 26.8;
server_side_border = 2;

rpi_width = 65;

electronic_board_width = 80;

boards_clearance = 8;

m3_nuts_width = 5.7;
spacer_width = m3_nuts_width * 4;
spacer_thickness = 3;

front_arm_angle = 100/2; // In degrees, between the two arms

spacer_opposite = sin(front_arm_angle) * spacer_width;
spacer_adjacent = cos(front_arm_angle) * spacer_width;

body_lenght = 100;

half_behind_width = servo_width/2 + server_side_border;

front_width = max(electronic_board_width, rpi_width) + boards_clearance*2 - spacer_adjacent*2;


echo(front_arm_angle);


difference() {

linear_extrude(4)
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

  translate([front_width/2+spacer_adjacent/2, body_lenght-spacer_opposite/2, 0])
  rotate([0,0,-front_arm_angle])
  translate([0,-spacer_thickness/2,0])
  cube([spacer_width/2,spacer_thickness,10], center=true);
  
  translate([-front_width/2-spacer_adjacent/2, body_lenght-spacer_opposite/2, 0])
  rotate([0,0,front_arm_angle])
  translate([0,-spacer_thickness/2,0])
  cube([spacer_width/2,spacer_thickness,10], center=true);


  union() {
      cylinder();
  }

}