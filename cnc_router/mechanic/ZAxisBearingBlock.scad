use <BallNut.scad>;

ballBearingCutoutWidth = 4000;
ballBearingBottomCutoutHeight = 1000;
ballBearingTopCutoutHeight = 2400;
ballBearingBottomCutoutWidth = 4000;
spindleMountWidth = 1200;

module ZAxisBearingBlock(height=12500, width=10000, guideRadius=600, guideBlockDepth=3600, guideBlockHeight=6000, guideXOffset=1700, guideYOffset=1800) {
  difference() {
    cube([width, guideBlockDepth, guideBlockHeight]);

    guideHoleRadius = guideRadius + 450;

    // Guide rod holes.
    translate([width - guideXOffset, guideYOffset, height / 2]) {
      cylinder(height + 1, guideHoleRadius, guideHoleRadius, center=true);
    }
    translate([guideXOffset, guideYOffset, height / 2]) {
      cylinder(height + 1, guideHoleRadius, guideHoleRadius, center=true);
    }

    // Ball screw hole.
    translate([width / 2, guideYOffset, height / 2]) {
      cylinder(height + 1, guideHoleRadius, guideHoleRadius, center=true);
    }

    // Ball bearing cutout top.
    translate([width / 2, guideBlockDepth / 2, guideBlockHeight - ballBearingTopCutoutHeight / 2]) {
      cube([ballBearingCutoutWidth, guideBlockDepth + 1, ballBearingTopCutoutHeight + 1], center=true);
    }

    // Ball bearing cutout bottom.
    translate([width / 2, guideBlockDepth / 2, ballBearingBottomCutoutHeight / 2]) {
      cube([ballBearingCutoutWidth, guideBlockDepth + 1, ballBearingBottomCutoutHeight + 1], center=true);
    }

    // Front cutout.
    translate([width / 2, 0, guideBlockHeight / 2]) {
      cube([width - spindleMountWidth * 2, 500, guideBlockHeight + 1], center=true);
    }
  }

  ballBearingHeight = 800;
  translate([width / 2, guideBlockDepth / 2, ballBearingHeight / 2 + (ballBearingBottomCutoutHeight - ballBearingHeight)]) {
    BallNutSquare(guideRadius, ballBearingHeight);
  }
}

ZAxisBearingBlock();
