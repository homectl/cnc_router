module BallNutSquare(r=600, h=800) {
  difference() {
    intersection() {
      cube([3000, 3000, h], center=true);
      cylinder(h, 2000, 2000, center=true);
    }
    cylinder(h + 1, r + 300, r + 300, center=true);
  }
}

module BallNutRound(r=800, h=1000) {
  difference() {
    intersection() {
      cylinder(r=2400, h=h, center=true);
      cube([3950, 5000, h], center=true);
    }
    cylinder(h + 1, r + 350, r + 350, center=true);
  }
}

BallNutSquare();
