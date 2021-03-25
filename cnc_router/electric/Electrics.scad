use <Backplate.scad>;
use <Mesa.scad>;
use <PSU.scad>;
use <RaspberryPi.scad>;
use <VFD.scad>;
use <TB6600.scad>;

module Electrics_TB6600() {
  translate([L_TB6600()/2, H_TB6600()/2, W_TB6600()/2]) {
    rotate([90, 180, 180]) TB6600(center=true);
  }
}

module Electrics_PSU() {
  translate([0, 0, 0]) rotate([0, -90, -90]) PSU();
}

module Electrics_VFD() {
  VFD(flat=true);
}

module Electrics_MESA7i76e() {
  translate([0, L_MESA()/2, W_MESA()/2]) rotate([0, 90, 0]) Mesa7i76e();
}

module Electrics_RaspberryPi() {
  translate([0, L_RPI()/2, W_RPI()/2]) rotate([0, 90, 0]) RaspberryPi();
}

module Electrics() {
  color("silver") Backplate();
  translate([0, 0, H_BACKPLATE()]) {
    for (i = [1:3]) {
      translate([W_BACKPLATE() - L_PSU() - 1000, L_BACKPLATE() - 2000 - (H_PSU() + 2000) * i, 0]) {
        Electrics_PSU();
        translate([-L_TB6600() - 1500, 0, 0]) Electrics_TB6600();
      }
    }

    translate([1500, 13000, 0]) Electrics_VFD();

    translate([30000, 13000, 0]) Electrics_MESA7i76e();

    translate([15000, 3000, 0]) Electrics_RaspberryPi();
  }
}

Electrics();
