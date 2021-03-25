use <../common/finalise.scad>;
use <../common/holes.scad>;
use <../common/rounded_cube.scad>;

module VFDMiddleInner(w, l, h, rounded) {
  r_cutout = 8000 - h * 0.44;
  d_cutout = 1100;

  difference() {
    cube([w, l, h], center=true);
    mirror_drilling([0, 0, 1]) mirror_drilling([1, 0, 0]) translate([-w/2, 0, -h/2]) {
      if (rounded) {
        rounded_cube([d_cutout * 2, l + 1, d_cutout * 2], r=r_cutout, apply_to="x");
      } else {
        cube([d_cutout * 2, l + 1, d_cutout * 2 + 1], center=true);
      }
    }
  }
}

module VFDMiddle(w, l, h, d_plastic, rounded, center=false) {
  centroid = center ? [0, 0, 0] : [w/2, l/2, h/2];
  translate(centroid) difference() {
    VFDMiddleInner(w, l, h, rounded);
    VFDMiddleInner(w - d_plastic * 2, l + 1, h - d_plastic * 2, rounded);
  }
}

module VFDBack(w, l, h, d_plastic, rounded, center=false) {
  l_backplate = 720;

  centroid = center ? [0, 0, 0] : [w/2, (l - l_backplate)/2, h/2];
  translate(centroid) {
    VFDMiddle(w, l - l_backplate, h, d_plastic, rounded, center=true);

    translate([0, l / 2, 0]) difference() {
      cube([w, l_backplate, h], center=true);

      r_screwhole = 290;
      o_screwhole = 385;
      quad_drilling() translate([w/2 - r_screwhole - o_screwhole, 0, h/2 - r_screwhole - o_screwhole]) {
        rotate([90, 0, 0]) cylinder(r=r_screwhole, h=l_backplate + 1, center=true);
      }
    }
  }
}

module VFDDisplay(w, l, h) {
  color("#aaa") cube([w, l, h], center=true);

  module button(x, y, c, t) {
    translate([-w/2 + 1200 + 1600 * x, 0, -(3200 + 1600 * y)]) {
      rotate([90, 0, 0]) {
        color(c) square([1000, 1000], center=true);
        translate([-100 * len(t), -100, 10]) text(t, size=200);
      }
    }
  }
  
  translate([0, -l/2, h/2 - 400]) {
    translate([0, 0, -1200]) rotate([90, 0, 0]) {
      color("#666") square([4000, 1400], center=true);
    }

    button(0, 0, "#333", "F/R");
    button(1, 0, "#333", "\u25ba\u25ba");
    button(0, 1, "#5e5", "RUN");
    button(1, 1, "#333", "\u25b2");
    button(2, 1, "#333", "PRGM");
    button(0, 2, "#e55", "STOP");
    button(1, 2, "#333", "\u25bc");
    button(2, 2, "#333", "SET");

    translate([1600, -l/2, -3200]) rotate([90, 0, 0]) {
      color("#555") cylinder(1200, 550, 450, center=true);
    }

    color("yellow") {
      translate([-2000, 0, 0]) rotate([90, 0, 0]) text("COM ALM DISP RUN Hz RPM", size=200);
      translate([2000, 0, -600]) rotate([90, 0, 0]) text("FOR", size=200);
      translate([2000, 0, -2000]) rotate([90, 0, 0]) text("REV", size=200);
    }
  }
}

module VFDFront(w, l, h, d_plastic, open, rounded, center=false) {
  r = w * 1.5;
  h_front_top = 10900;

  w_display = 5500;
  l_display = 1400;
  h_display = 7800;
  z_display = 2000;
  
  centroid = center ? [0, 0, 0] : [w/2, l/2, h/2];
  translate(centroid) {
    difference() {
      intersection() {
        VFDMiddleInner(w, l, h, rounded);
        translate([0, r - l / 2, 0]) cylinder(r=r, h=h, center=true, $fn=100);
        translate([-w/2, -l/2, open ? h / 2 - h_front_top : -h/2]) cube([w, l, open ? h_front_top : h]);
      }

      l_flatten = 400;
      translate([0, -(l - l_flatten)/2, (h - h_display)/2 - z_display]) {
        cube([w, l_flatten, h_display], center=true);
        translate([0, l_display / 2, 0])
        cube([w_display, l_display, h_display], center=true);
      }

      translate([0, -(l - l_display)/2, h/2 - z_display]) {
        sphere(r=l_display);
      }
    }

    translate([0, -(l - l_display)/2, (h - h_display)/2 - z_display]) {
      VFDDisplay(w_display, l_display, h_display);
    }
  }
}

function W_VFD() = 12550;
function L_VFD() = 16160;
function H_VFD() = 17000;

module VFD(w=W_VFD(), l=L_VFD(), h=H_VFD(), rounded=true, open=true, center=false, flat=false) {
  l_back = 5800;
  l_middle = 8000;
  l_front = 2360;

  d_plastic = 280;

  finalise(w, l, h, center, flat) {
    VFDFront(w, l_front, h, d_plastic, open, rounded);
    translate([0, l_front, 0]) VFDMiddle(w, l_middle, h, d_plastic, rounded);
    translate([0, l_front + l_middle, 0]) VFDBack(w, l_back, h, d_plastic, rounded);
  }
}

VFD(center=true);
