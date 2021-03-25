use <Ports.scad>;

function W_RPI() = 5600;
function L_RPI() = 8500;
function H_RPI() = 2000;

module RaspberryPiPin(w) {
  // 500, 5079
  w_base = w;
  l_base = w;
  h_base = w;
  color("#444") cube([w_base, l_base, h_base]);

  w_pin = 65;
  l_pin = 65;
  h_pin = 615;
  translate([(w_base - w_pin)/2, (l_base - l_pin)/2, h_base/2]) {
    color("silver") cube([w_pin, l_pin, h_pin]);
  }
}

module RaspberryPiGPIO() {
  w_base = 250;
  for (i = [0:19]) {
    for (j = [0:1]) {
      translate([w_base * i, w_base * j, 0]) RaspberryPiPin(w_base);
    }
  }
}

module RaspberryPiUSB(w) {
  l = 1756;
  h = 1565;

  difference() {
    cube([w, l, h]);
    translate([100 - 1, -100, 100]) cube([w - 200, l, (h / 2) - 200]);
    translate([100 - 1, -100, h/2 + 100]) cube([w - 200, l, (h / 2) - 200]);
  }
}

module RaspberryPiUSBC() {
  w = 900;
  l = 733;
  h = 330;

  translate([0, -l, 0]) {
    color("silver") difference() {
      cube([w, l, h]);
      translate([-1, 40, 40]) cube([w - 80, l - 80, h - 80]);
    }

    translate([0, (l - 600)/2, (h - 90)/2]) {
      color("#666") cube([700, 600, 90]);
    }
  }
}

module RaspberryPi(w=W_RPI(), l=L_RPI()) {
  h_pcb = 150;

  color("#5c5") cube([w, l, h_pcb], center=true);
  translate([0, 0, h_pcb/2]) {
    w_cpu = 1500;
    l_cpu = w_cpu;
    color("silver") translate([(w - w_cpu)/2 - 1600, (l - l_cpu)/2 - 2236, 0]) {
      cube([w_cpu, l_cpu, 200], center=true);
    }

    translate([w/2 - 100, -l/2 + 2800, 0]) rotate([0, 0, 90]) RaspberryPiGPIO();

    translate([w/2 - W_RJ45() - 100, -l/2 - 200, 0]) Port_RJ45();

    w_usb = 1325;
    translate([w/2 - W_RJ45() - 100 - w_usb - 411, -l/2 - 200, 0]) RaspberryPiUSB(w_usb);
    translate([w/2 - W_RJ45() - 100 - w_usb - 411 - w_usb - 460, -l/2 - 200, 0]) RaspberryPiUSB(w_usb);

    translate([-w/2 - 100, l/2 - 680, 0]) RaspberryPiUSBC();
  }
}

RaspberryPi();
