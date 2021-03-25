use <../common/holes.scad>;

module PSUBottom(w, l, h, d_metal, d_pcb) {
  difference() {
    cube([w, l, h], center=true);
    translate([0, -d_metal/2, d_pcb/2]) {
      cube([w - d_metal * 2, l - d_metal + 5, h - d_pcb + 1], center=true);
    }
  }
}

module PSUFanCutout(r_outer, r_inner, d_metal) {
  difference() {
    cylinder(r=r_outer, h=d_metal + 1, center=true);
    cylinder(r=r_inner, h=d_metal + 2, center=true);

    cube([r_outer * 2, 500, d_metal + 5], center=true);
    rotate([0, 0, 180/3*2]) cube([r_outer * 2, 500, d_metal + 5], center=true);
    rotate([0, 0, 180/3]) cube([r_outer * 2, 500, d_metal + 5], center=true);
  }
}

module PSUTop(w, l, h, d_metal) {
  difference() {
    cube([w, l, h], center=true);
    translate([0, 0, -d_metal/2]) {
      cube([w - d_metal * 2, l - d_metal * 2, h - d_metal + 5], center=true);
    }

    w_cutout = 2500;
    l_cutout = 300;

    translate([0, 0, (h - d_metal)/2]) {
      mirror_drilling() {
        for (i = [0:4]) {
          translate([-(w - w_cutout)/2 + 2000, -(l - l_cutout)/2 + 1050 + i * 700, 0]) {
            cube([w_cutout, l_cutout, d_metal + 5], center=true);
          }
        }
      }

      r_outer = 2950;
      r_inner = 2400;
      w_space = 310;
      translate([-w/2 + r_outer + 650, l/2 - r_outer - 1300, 0]) {
        PSUFanCutout(r_outer, r_inner, d_metal);
        rotate([0, 0, 180/6]) {
          PSUFanCutout(r_inner - w_space, r_inner - w_space - (r_outer - r_inner), d_metal);
        }
      }
    }
  }
}

module PSUScrewTerminalForeach(pins, w, l, h, w_pin, l_pin, h_pin, w_separator) {
  for (i = [0:pins-1]) {
    translate([-(w - w_pin)/2 + w_separator + (w_pin + w_separator) * i, -(l - l_pin) / 2, (h - h_pin)/2]) {
      children();
    }
  }
}

module PSUScrewTerminalScrew(h) {
  r = 350;
  h_depth = 100;

  difference() {
    cylinder(r=r, h=h, center=true);
    translate([0, 0, (h - h_depth) / 2]) cube([r*2 + 1, 100, h_depth + 5], center=true);
    translate([0, 0, (h - h_depth) / 2]) cube([100, r * 1.5, h_depth + 5], center=true);
  }
}

module PSUScrewTerminal(pins, center=true) {
  w_separator = 140;
  w_pin = 800;
  l_pin = 1400;
  h_pin = 600;
  w = w_separator + (w_separator + w_pin) * pins;
  l = 1500;
  h = 1300;

  centroid = center ? [0, 0, 0] : [w/2, l/2, h/2];
  translate(centroid) {
    difference() {
      cube([w, l, h], center=true);
      PSUScrewTerminalForeach(pins, w, l, h, w_pin, l_pin, h_pin, w_separator) {
        cube([w_pin, l_pin + 5, h_pin + 5], center=true);
      }
    }

    h_screw = 500;
    PSUScrewTerminalForeach(pins, w, l, h, w_pin, l_pin, h_pin, w_separator) {
      translate([0, 0, -(h_pin - h_screw)]) {
        PSUScrewTerminalScrew(h_screw);
      }
    }
  }
}

function W_PSU() = 11500;
function L_PSU() = 21500;
function H_PSU() = 5000;

module PSU(w=W_PSU(), l=L_PSU(), h=H_PSU(), center=false) {
  d_metal = 150;
  d_pcb = 860;
  h_top = 2400;
  l_bottom = 2000;

  centroid = center ? [0, 0, 0] : [w/2, l/2, h/2];
  translate(centroid) {
    PSUBottom(w, l, h, d_metal, d_pcb);
    translate([0, l_bottom/2 - d_metal, (h - h_top)/2]) {
      PSUTop(w - d_metal * 3, l - l_bottom - d_metal, h_top, d_metal);
    }
    translate([-w/2 + d_metal + 1800, -l/2 + d_metal, -h/2 + d_metal + d_pcb]) {
      PSUScrewTerminal(9, center=false);
    }
  }
}

PSU();
