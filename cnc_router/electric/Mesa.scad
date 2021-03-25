use <Ports.scad>;

function W_MESA() = 10000;
function L_MESA() = 16500;
function H_MESA() = 3000;

module Mesa7i76e_Terminal(i, j, c="#ada") {
  w_terminal = 2100;
  l_terminal = 1040;
  h_terminal = 2170;
  o_terminal = 1190;

  translate([740 + j * w_terminal, 6480 + (l_terminal + o_terminal) * i, 0]) {
    color(c) cube([w_terminal, l_terminal, h_terminal]);
  }
}

module Mesa7i76e_Pins(w, l, h) {
  color("#666") {
    difference() {
      cube([w, l, h]);
      translate([50, 50, 100]) cube([w - 100, l - 100, h - 100 + 1]);

      w_cutout = 200;
      translate([(w - w_cutout)/2, -0.5, 100]) {
        cube([w_cutout, 50 + 1, h - 100 + 1]);
      }
    }
  }
}

module Mesa7i76e(w=W_MESA(), l=L_MESA()) {
  h_pcb = 150;

  color("#5c5") cube([w, l, h_pcb], center=true);
  translate([-w/2, -l/2, h_pcb/2]) {
    w_cpu = 1700;
    l_cpu = w_cpu;
    translate([4500, 1450, 0]) {
      color("#777") cube([w_cpu, l_cpu, 100]);
    }

    translate([740, -200, 0]) Port_RJ45();

    w_pins = 4061;
    l_pins = 860;
    h_pins = 710;

    translate([740, 4150, 0]) Mesa7i76e_Pins(w_pins, l_pins, h_pins);
    translate([740 + w_pins + 380, 4150, 0]) Mesa7i76e_Pins(w_pins, l_pins, h_pins);

    for (i = [0, 1, 3, 4]) {
      for (j = [0:3]) {
        Mesa7i76e_Terminal(i, j);
      }
    }

    Mesa7i76e_Terminal(2, 0, "orange");
    Mesa7i76e_Terminal(2, 3);

    translate([8450, -1000, 0]) color("#ada") cube([850, 1800, 800]);
  }
}

Mesa7i76e();
