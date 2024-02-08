import g4p_controls.*;

float baseH = 60;
float armL1 = 60;
float armL2 = 40;
float armW1 = 10;
float armW2 = 10;

float angle0 = 0;
float angle1 = 0;
float angle2 = radians(45); // アーム2の初期角度
float dif = 0.02;
float armExtendSpeed = 0.5; // アームの伸縮速度

boolean reverseRotation = false; // 逆回転フラグ
boolean clockwiseRotation = false; // 時計回りフラグ
boolean extendArm = false; // アームの伸縮フラグ
boolean rotateClockwise = false; // アーム1の時計回り回転フラグ
boolean rotateCounterClockwise = false; // アーム1の反時計回り回転フラグ
boolean extendBase = false; // ベースの伸縮フラグ

void setup() {
  size(1200, 800, P3D);
  camera(100, 100, 100, 0, 0, 0, 0, 0, -1);
  noStroke();
}

void draw() {
  background(255);

  // アーム1の角度の更新
  if (keyPressed) {
    if (key == 'w') {
      rotateClockwise = true;
      rotateCounterClockwise = false;
    } else if (key == 's') {
      rotateCounterClockwise = true;
      rotateClockwise = false;
    } else {
      rotateClockwise = false;
      rotateCounterClockwise = false;
    }
    
    if (key == 'q') {
      baseH += 1;
    } else if (key == 'e') {
      baseH = max(baseH - 1, 10); // ベースの高さが0以下にならないようにする
    }
    
    if (key == 'f') {
      clockwiseRotation = true;
    }
  } else {
    rotateClockwise = false;
    rotateCounterClockwise = false;
    clockwiseRotation = false;
  }

  if (rotateClockwise) {
    angle1 += dif;
  } else if (rotateCounterClockwise) {
    angle1 -= dif;
  }

  if (clockwiseRotation) {
    angle1 += dif;
    angle2 += dif;
  }

  translate(0, 0, baseH / 2);
  fill(175);
  drawBox(10, 10, baseH);

  // 1つ目のリンク
  rotateZ(angle1); // アーム1の角度を適用
  translate(0, armL1 / 2 - armW1 / 2, baseH / 2 + armW1 / 2);
  fill(150);
  drawBox(armW1, armL1, armW1);

  // 2つ目のリンク
  if (keyPressed) {
    if (key == 'p') {
      armL2 += armExtendSpeed; // アーム2の長さを増加
    } else if (key == 'l') {
      armL2 = max(armL2 - armExtendSpeed, 10); // アーム2の長さを減少させるが、最小値は10に制限
    } else if (key == 'a') {
      angle2 -= dif; // 反時計回りに回転
    } else if (key == 'd') {
      angle2 += dif; // 時計回りに回転
    }
  }

  translate(0, armL1 * 0.5, -10);  // 2つ目のアームの先端が1つ目のアームの先端にもっと寄せる
  rotateZ(angle2);
  translate(0, armW2, 0);
  fill(125);
  drawBox(armW2, armL2, armW2);
}

void drawBox(float w, float h, float d) {
  box(w, h, d);
}
