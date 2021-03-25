use <Ballscrew.scad>;
use <SpindleMount.scad>;
use <StepperProtector.scad>;
use <ZAxisBearingBlock.scad>;
use <ZAxisBottomPlate.scad>;
use <ZAxisTopPlate.scad>;

use <../common/triangle.scad>;

Z_POS = $t > 0.5 ? 1 - ($t - 0.5) * 2 : $t * 2;

ballBearingCutoutWidth = 4000;
ballBearingBottomCutoutHeight = 1000;
ballBearingTopCutoutHeight = 2400;
ballBearingBottomCutoutWidth = 4000;
spindleMountWidth = 1200;

module ZAxisMount(height, width, guideRadius, guideBlockDepth, guideBlockHeight, guideXOffset, guideYOffset) {
  ZAxisBearingBlock(height, width, guideRadius, guideBlockDepth, guideBlockHeight, guideXOffset, guideYOffset);

  color("#ddd") translate([0, -10000 + 100, 0]) SpindleMount(guideBlockHeight, spindleDiameter=8000);
}

module ZAxis(height, width, center=false) {
  stepperProtectorR = 1400;

  guideBlockDepth = 3600;
  guideBlockHeight = 6000;

  guideRadius = 600;
  ballScrewRadius = 600;

  zPlateThickness = 1000;
  bottomPlateLength = 10000;
  topPlateLength = 11200;

  guideXOffset = guideRadius + 1100;
  guideYOffset = guideRadius + 1200;

  centroid = center ? [-width/2, 0, -height/2] : [0, 0, zPlateThickness];
  translate(centroid) {
    // Bottom plate.
    ZAxisBottomPlate(width, bottomPlateLength, zPlateThickness);

    translate([0, 0, zPlateThickness]) {
      // Top plate.
      translate([0, bottomPlateLength - topPlateLength, height]) {
        ZAxisTopPlate(width, topPlateLength, zPlateThickness, stepperProtectorR);
      }

      // Guide rods.
      translate([width - guideXOffset, guideYOffset, 0]) {
        cylinder(height, guideRadius, guideRadius);
      }
      translate([guideXOffset, guideYOffset, 0]) {
        cylinder(height, guideRadius, guideRadius);
      }

      // Ball screw.
      translate([width / 2, guideYOffset, 0]) {
        Ballscrew(height, guideRadius);
      }

      protectorLength = 3800;
      translate([width / 2, guideYOffset, height - protectorLength / 2 + 600]) {
        color("white") StepperProtector(stepperProtectorR, protectorLength);
      }

      zAxisTravel = height - (protectorLength - ballBearingTopCutoutHeight) - guideBlockHeight + 600;
      echo(str("Z Axis Travel: ", zAxisTravel));
      translate([0, 0, zAxisTravel * Z_POS]) {
        ZAxisMount(height, width, guideRadius, guideBlockDepth, guideBlockHeight,
                  guideXOffset, guideYOffset);
      }
    }
  }
}

ZAxis(height=12500, width=10000);
