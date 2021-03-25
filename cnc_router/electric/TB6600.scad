use <../common/holes.scad>;

function W_TB6600() = 5660;
function L_TB6600() = 9600;
function H_TB6600() = 2790;

module TB6600ScrewTerminal(w, l, h) {
  difference() {
    cube([l, w, h], center=true);
    w_cutout = 500;
    h_cutout = 760;
    translate([0, w_cutout, h_cutout/2]) cube([l + 1, w_cutout + 1, h_cutout + 1], center=true);

    r_screw = 190;
    d_screw = 1200;
    offset_init = 67;
    for (i = [0:11]) {
      translate([-l/2 + 190 + offset_init + (l / 12) * i, -100, (h - d_screw)/2]) {
        cylinder(r=r_screw, h=d_screw + 1, center=true);
        w_insert = 270;
        h_insert = 350;
        l_insert = 800;
        translate([0, -l_insert/2, -(d_screw - h_insert)/2]) cube([w_insert, l_insert, h_insert], center=true);
        translate([0, -w/2 + 250, h/2 - 200]) cube([270, 100, 100 + 1], center=true);
        translate([0, -w/2 + 250, -h/2 - 100]) cube([270, 100, 100 + 1], center=true);
      }
    }
  }
}

module TB6600Heatsink(w, l, h, w_screwplate, h_radiator) {
  difference() {
    cube([l, w, h], center=true);
    translate([0, -w_screwplate/2, -h_radiator/2]) cube([l + 1, w - w_screwplate + 1, h - h_radiator + 1], center=true);

    w_square = 500;
    mirror_drilling() translate([l/2 - w_square, (w - w_screwplate)/2, 0]) {
      r = 450/2;
      rotate([90, 0, 0]) cylinder(r=r, h=w_screwplate + 1, center=true);
      translate([w_square/2, 0, 0]) cube([w_square + 1, w_screwplate + 1, r * 2], center=true);
    }

    for (i = [0:8]) {
      w_cutout = 530;
      translate([0, (w - w_cutout)/2 - 150 - (w_cutout + 80) * i, (h - h_radiator + w_screwplate)/2]) {
        cube([l + 1, w_cutout, h_radiator - w_screwplate + 1], center=true);
      }
    }
  }
}

module TB6600(center=false) {
  w_heatsink = W_TB6600();
  l_heatsink = L_TB6600();
  h_heatsink = H_TB6600();
  w_screwplate = 254;
  h_radiator = 800;

  l_terminal = 6100;
  w_terminal = 1400;
  h_terminal = 1500;

  centroid = center ? [0, 0, 0] : [l_heatsink/2, w_heatsink/2, h_heatsink/2];

  translate(centroid) {
    color("#999") {
      TB6600Heatsink(w_heatsink, l_heatsink, h_heatsink, w_screwplate, h_radiator);
      translate([0, -w_screwplate/2, -(h_heatsink - 2000)/2]) {
        cube([l_heatsink - 1400, w_heatsink - 290, h_heatsink - h_radiator - 10], center=true);
      }
    }

    color("#5c5") {
      translate([0, -(w_heatsink + w_terminal)/2 - 1, -h_terminal/2]) {
        rotate([0, 180, 0]) TB6600ScrewTerminal(w_terminal, l_terminal, h_terminal);
      }
    }
  }
}

TB6600(center=false);
