use <../common/holes.scad>;

function W_BACKPLATE() = 35000;
function L_BACKPLATE() = 54800;
function H_BACKPLATE() = 1200;

module Backplate(w=W_BACKPLATE(), l=L_BACKPLATE(), h=H_BACKPLATE(), center=false) {
  d_metal = 90;
  w_gap = 200;

  centroid = center ? [0, 0, 0] : [w/2, l/2, h];
  translate(centroid) difference() {
    union() {
      cube([w, l, d_metal], center=true);
      translate([0, 0, -h/2]) {
        translate([0, -l/2, 0]) cube([w - w_gap, d_metal, h], center=true);
        translate([0, l/2, 0]) cube([w - w_gap, d_metal, h], center=true);
        translate([-w/2, 0, 0]) cube([d_metal, l - w_gap, h], center=true);
        translate([w/2, 0, 0]) cube([d_metal, l - w_gap, h], center=true);
      }
    }

    w_cutout = 2000;
    l_cutout = 900;
    quad_drilling([0, 1, 0]) translate([-(w - w_cutout)/2 + 1000, -(l - l_cutout)/2 + 2000, 0]) {
      cube([w_cutout, l_cutout, d_metal + 10], center=true);
    }
  }
}

Backplate();
