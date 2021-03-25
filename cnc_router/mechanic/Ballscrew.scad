use <../common/springs.scad>;

module Ballscrew(h, r, accurate=true, center=false) {
  difference() {
    cylinder(h, r, r, center=center);
    translate([0, 0, -0.5]) {
      if (accurate) {
        spring(H=h, r=r/3, windings=h/r, R=r, $fn=10, center=center);
      } else {
        linear_extrude(height=h+1, center=center, convexity=10, twist=-h/8, $fn=10) {
          translate([r, 0, 0]) circle(r/2);
        }
      }
    }
  }
}

Ballscrew(52000, 1000);
