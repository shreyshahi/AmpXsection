//Global variables 
int ssNSS=0;
int firstPointFlag;
int selCase = 1;
PFont plotFont;
int selT = 1;
int plotFlag =1;
int flagFirstPt=1;
int firstPassFlag = 1;
float pX1=0;
float pX2=0;
float pY1=600;
float pY2=600;

String[] T = {"1","3","5"}; 

String[] ssNames = {"ss1","ss2","ss3","ss4","ss5","so6"};

String[] nssNames = {"rv1","rv2","rv3","rv4","rv5","ro6","rv7"};

String[] ssModels = {"abr00","abr10","row10","sha10_new","som97","spu08"};
int[] ssR = {220,255,65,180,139,238};
int[] ssG = {20,192,105,238,136,201};
int[] ssB = {60,203,255,180,120,0};
String[] nssModels = {"row10","sha10_new","som97","spu08"};
int[] nssR = {65,180,139,238};
int[] nssG = {105,238,136,201};
int[] nssB = {255,180,120,0};

int[] xmin = {0,0,0,0,-70,-70,-70,-70,-70,-70,-70,-70,-70};
int[] xmax = {71,71,71,71,85,76,74,83,83,95,95,95,117};
int[] ymin = {-70,-70,-70,-70,-70,-70,-70,-70,-70,-70,-70,-70,-70};
int[] ymax = {76,95,150,305,105,150,76,88,88,102,150,102,139};

float[] rmin = {0.8};
float[] rmax = {1.2};

FloatTable data;

void setup() {
  size(1050,700);
  background(255,255,255);
}

void draw() {
  stroke(0);

  if(ssNSS == 0) {
    drawSS();
  }
  else {
    drawNSS();
  }

  drawTboxes();

  stroke(255);
  fill(240);
  // filler
  rect(0,150,500,100); // filler
  rect(0,600,500,100); // filler

  stroke(0);
  fill(255);
  rect(0,200,500,400); // map
  drawFault();
  drawGrid();
  if(flagFirstPt == 1) {
    showLine();
  }
  else {
    drawLine();
  }
  drawPlotBox2(); // changed from drawPlotBox
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont);
  fill(0);
  text("Strike-Slip",225,25);
  text("Non-Strike-Slip",720,25);
  if(firstPassFlag == 1){
    drawLegend();
    drawScreenshotButton();
  }
}
void drawScreenshotButton(){
  stroke(0);
  fill(0);
  rect(500,630,550,70);
  fill(250);
  rect(510,640,530,50);
  fill(0);
  text("Take Screenshot",710,660);
}
void drawLegend(){
  firstPassFlag = 0;
  strokeWeight(2);
  //textAlign(LEFT,CENTER);
  stroke(220,20,60);
  line(510,125,550,125);
  stroke(255,192,203);
  line(680,125,720,125);
  stroke(65,105,255);
  line(840,125,880,125);
  stroke(180,238,180);
  line(510,175,550,175);
  stroke(139,136,120);
  line(680,175,720,175);
  stroke(238,201,0);
  line(840,175,880,175);
  strokeWeight(1);
  fill(0);
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont);
  text(ssModels[0],560,125);
  text(ssModels[1],730,125);
  text(ssModels[2],890,125);
  text("sha10",560,175);
  text(ssModels[4],730,175);
  text(ssModels[5],890,175);
}
void drawGrid(){
 stroke(240);
 strokeWeight(0.5);
 int caseNo;
 if(ssNSS == 0) {
    caseNo = selCase-1;
 }
 else {
    caseNo = 6 + selCase -1;
 }
 
 int numVert = floor((xmax[caseNo] - xmin[caseNo])/10);
 textAlign(CENTER, TOP);
 textSize(10);
 for(int i =0; i<numVert; i++){
   line(float(i*10)/(xmax[caseNo] - xmin[caseNo])*500,600,float(i*10)/(xmax[caseNo] - xmin[caseNo])*500,200);
   fill(0);
   text(" " + (xmin[caseNo]+i*10),float(i*10)/(xmax[caseNo] - xmin[caseNo])*500,605);
 }
 
 int numHor = floor((ymax[caseNo] - ymin[caseNo])/10);
 textAlign(LEFT, CENTER);
 textSize(10);
 for(int i =0; i<numHor; i++){
   line(0,600-float(i*10)/(ymax[caseNo] - ymin[caseNo])*400,500,600-float(i*10)/(ymax[caseNo] - ymin[caseNo])*400);
   fill(0);
   text(" " + (ymin[caseNo]+i*10),5,600-float(i*10)/(ymax[caseNo] - ymin[caseNo])*400);
 }
 
 stroke(0);
 fill(255);
}

void drawTboxes() {
  stroke(0);
  fill(240);
  rect(0,100,500/3,50);
  rect(500/3,100,500/3,50);
  rect(2*500/3,100,500/3,50); 
  fill(255,0,0);
  rect((selT-1)*500/3,100,500/3,50);
  fill(0);
  text("T = " + T[0],(0+500/3)/2-10,125);
  text("T = " + T[1],(500)/2-10,125);
  text("T = " + T[2],(5*500/3)/2-10,125);
}

void showLine() {
  line(pX1,pY1,pX2,pY2);
  fill(0);
  textSize(12);
  text("A",pX1,pY1);
  text("B",pX2,pY2); 
  int caseNo;
  if(ssNSS == 0) {
    caseNo = selCase -1 ;
  }
  else {
    caseNo = 6 + selCase -1 ;
  }
  fill(0);
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont);
  String sX1 = "X1 = "+(xmin[caseNo] + pX1*(xmax[caseNo]-xmin[caseNo])/500);
  int posX1 = sX1.indexOf(".");
  String sX2 = "X2 = "+(xmin[caseNo] + pX2*(xmax[caseNo]-xmin[caseNo])/500);
  int posX2 = sX2.indexOf(".");
  String sY1 = "Y1 = "+(ymin[caseNo] + (600-pY1)*(ymax[caseNo]-ymin[caseNo])/400);
  int posY1 = sY1.indexOf(".");
  String sY2 = "Y2 = "+(ymin[caseNo] + (600-pY2)*(ymax[caseNo]-ymin[caseNo])/400);
  int posY2 = sY2.indexOf(".");
  
  text(sX1.substring(0,posX1+2),120,630);
  text(sX2.substring(0,posX2+2),120,670);
  text(sY1.substring(0,posY1+2),250,630);
  text(sY2.substring(0,posY2+2),250,670);
  fill(255);
}

void drawLine() {
  if(mouseX < 500 && mouseY > 200 && mouseY < 600) {
    line(pX1,pY1,mouseX,mouseY);
  }
  else {
    point(pX1,pY1);
  }
}

void mousePressed() {
  // check SS, NSS selection
  if(mouseY < 50) {
    checkSSNSS(mouseX);
    selCase = 1;
    plotFlag =1;
    initializeLine();
  }
  // check case selection
  if(mouseY > 50 && mouseY < 100) {
    checkCase(mouseX);
    plotFlag =1;
    initializeLine();
  }
  // check cross section selection
  if(mouseY > 200 && mouseY < 600 && mouseX < 500) {
    checkCrossSection(mouseX,mouseY);
  }
  // check T
  if(mouseY>100 && mouseY < 150 && mouseX<500) {
    selT = ceil(float(mouseX)/(500/3));
    plotFlag =1;
    initializeLine();
  }
  if(mouseX>500 && mouseY > 600){
    takeScreenshot();
  }
}

void takeScreenshot(){
   float num = random(100);
   String fn = "screenShot_" + num + ".jpg";
   save(fn);
}

void checkSSNSS(float X) {
  if(X < 500) {
    ssNSS = 0;
  }
  else {
    ssNSS = 1;
  }
}

void checkCase(float X) {
  int nCases;
  if(ssNSS == 0) {
    nCases = 6;
  }
  else {
    nCases = 7;
  }
  selCase = ceil(X/(1000/nCases));
}

void checkCrossSection(float X, float Y) {
  if(flagFirstPt == 1) {
    pX1 = mouseX;
    pY1 = mouseY;
    flagFirstPt =0;
    plotFlag = 1;
  }
  else {
    pX2 = mouseX;
    pY2 = mouseY; 
    flagFirstPt = 1;
    plotFlag = 0;
    drawAllPlots();
  }
}

void drawSS() {
  fill(255,0,0);
  rect(0,0,525,50); // Strike slip
  fill(240);
  rect(525,0,525,50); // non strike slip
  float caseW = 1050/6;
  for(int i =0; i<6; i++) {
    rect(0+i*caseW,50,caseW,50);
    fill(0);
    text(ssNames[i],(i*caseW+(i+1)*caseW)/2-10,75);
    fill(240);
  }
  fill(255,0,0);
  rect((selCase-1)*caseW,50,caseW,50); // selected test case
  fill(0);
  text(ssNames[selCase-1],((selCase-1)*caseW+(selCase)*caseW)/2-10,75);
  fill(255);
}

void drawNSS() {
  fill(240);
  rect(0,0,525,50); // Strike slip
  fill(255,0,0);
  rect(525,0,525,50); // non strike slip
  fill(240);
  float caseW = 1050/7;
  for(int i =0; i<7; i++) {
    rect(0+i*caseW,50,caseW,50);
    fill(0);
    text(nssNames[i],(i*caseW+(i+1)*caseW)/2-10,75);
    fill(240);
  }
  fill(255,0,0);
  rect((selCase-1)*caseW,50,caseW,50); // selected test case
  fill(0);
  text(nssNames[selCase-1],((selCase-1)*caseW+(selCase)*caseW)/2-10,75);
  fill(255);
}

void drawPlotBox2(){
  if(plotFlag == 1){
    rect(500,200,500,400);
    stroke(200);
    for(int i = 0; i<20;i++){
       line(500,200+i*20,1000,200+i*20); 
    }
    stroke(150);
    for(int i = 0; i<10;i++){
       line(500,200+i*40,1000,200+i*40); 
    }
    stroke(0);
    for(int i = 0; i<3;i++){
       line(500,200+i*200,1000,200+i*200); 
    }

    rect(1000,200,50,400);
    
    // tick values on y-axis
    textSize(10);
    fill(0);
    textAlign(LEFT,CENTER);
    String[] values = {"2.0","1.8","1.6","1.4","1.2","1.0","0.8","0.6","0.4","0.2"};
    for(int i = 0; i<10; i++){
      if(i > 0){
        text(values[i],1000+5,200+i*40);
      }else{
        text(values[i],1000+5,200+i*40+2);
      }
    }
    
    // Y-axis label
    textSize(15);
    pushMatrix();
    translate(1000+30,450);
    rotate(-HALF_PI);
    text("Amplification",0,0);
    popMatrix();
    fill(255);
    
    rect(500,600,550,30);
    // X-axis label
    fill(0);
    textSize(15);
    text("A",505,612);
    text("B",995,612);
    arrow(520,615,980,615);
    fill(255);
  }
}

void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
} 

/*
void drawPlotBox() {
  if(plotFlag == 1) {
    textSize(12);
    float caseH;
    if(ssNSS == 0) {
      caseH = 600/6;
      for(int i = 0; i<6; i++) {
        rect(500,100+i*caseH,500,caseH);
        fill(0);
        text(ssModels[i],950,100+i*caseH+10);
        fill(255);
        stroke(150);
        line(500,100+(float(i)+0.5)*caseH,1000,100+(float(i)+0.5)*caseH);
        stroke(0);
      }
    }
    else {
      caseH = 600/4;
      for(int i = 0; i<4; i++) {
        rect(500,100+i*caseH,500,caseH);
        fill(0);
        text(nssModels[i],950,100+i*caseH+10);
        fill(255);
        stroke(150);
        line(500,100+(float(i)+0.5)*caseH,1000,100+(float(i)+0.5)*caseH);
        stroke(0);
      }
    }
    textSize(20);
  }
}  
*/

float getFaultX(float x){
  int caseNo;
  if(ssNSS == 0) {
    caseNo = selCase -1 ;
  }
  else {
    caseNo = 6 + selCase -1 ;
  }
  float X;
  X = (x-xmin[caseNo])/(xmax[caseNo]-xmin[caseNo])*500;
 return X; 
}

float getFaultY(float y){
  int caseNo;
  if(ssNSS == 0) {
    caseNo = selCase -1 ;
  }
  else {
    caseNo = 6 + selCase -1 ;
  }
  float Y;
  Y = 600 - (y-ymin[caseNo])/(ymax[caseNo]-ymin[caseNo])*400;
  return Y;
}


void drawFault() {
  if(ssNSS == 0) {
    strokeWeight(2);
    switch(selCase){
      case 1:
        line(getFaultX(0.2),getFaultY(0),getFaultX(0.2),getFaultY(6));
        break;
      case 2:
        line(getFaultX(0.2),getFaultY(0),getFaultX(0.2),getFaultY(25));
        break;
      case 3:
        line(getFaultX(0.2),getFaultY(0),getFaultX(0.2),getFaultY(80));
        break;
      case 4:
        line(getFaultX(0.2),getFaultY(0),getFaultX(0.2),getFaultY(235));
        break;
      case 5:
        line(getFaultX(0),getFaultY(0),getFaultX(0),getFaultY(20));
        line(getFaultX(0),getFaultY(20),getFaultX(14.1),getFaultY(34.1));
        break;
      case 6:
        strokeWeight(1);
        stroke(220);
        fill(220);
        beginShape();
        vertex(getFaultX(0),getFaultY(0));
        vertex(getFaultX(0),getFaultY(80));
        vertex(getFaultX(5.1303),getFaultY(80));
        vertex(getFaultX(5.1303),getFaultY(0));
        endShape();
        fill(255);
        stroke(0);
        //line(getFaultX(0),getFaultY(0),getFaultX(0),getFaultY(80));
        break;
      default:
        break;     
    }
    strokeWeight(1);
  }
  else {
    stroke(220);
    switch(selCase){
      case 1:
        fill(220);
        beginShape();
        vertex(getFaultX(0),getFaultY(0));
        vertex(getFaultX(0),getFaultY(6));
        vertex(getFaultX(3.5355),getFaultY(6));
        vertex(getFaultX(3.5355),getFaultY(0));
        endShape();
        fill(255);
        break;
      case 2:
        fill(220);
        beginShape();
        vertex(getFaultX(0),getFaultY(0));
        vertex(getFaultX(0),getFaultY(18));
        vertex(getFaultX(12.7279),getFaultY(18));
        vertex(getFaultX(12.7279),getFaultY(0));
        endShape();
        fill(255);
        break;
      case 3:
        fill(220);
        beginShape();
        vertex(getFaultX(0),getFaultY(0));
        vertex(getFaultX(0),getFaultY(18));
        vertex(getFaultX(12.7279),getFaultY(18));
        vertex(getFaultX(12.7279),getFaultY(0));
        endShape();
        fill(255);
       break;
      case 4:
        fill(220);
        beginShape();
        vertex(getFaultX(0),getFaultY(0));
        vertex(getFaultX(0),getFaultY(32));
        vertex(getFaultX(24.2487),getFaultY(32));
        vertex(getFaultX(24.2487),getFaultY(0));
        endShape();
        fill(255);
       break;
      case 5:
        fill(220);
        beginShape();
        vertex(getFaultX(0),getFaultY(0));
        vertex(getFaultX(0),getFaultY(80));
        vertex(getFaultX(24.2487),getFaultY(80));
        vertex(getFaultX(24.2487),getFaultY(0));
        endShape();
        fill(255);
       break;
      case 6:
        fill(220);
        beginShape();
        vertex(getFaultX(0),getFaultY(0));
        vertex(getFaultX(0),getFaultY(32));
        vertex(getFaultX(24.2487),getFaultY(32));
        vertex(getFaultX(24.2487),getFaultY(0));
        endShape();
        fill(255);
       break;
      case 7:
        fill(220);
        beginShape();
        vertex(getFaultX(0),getFaultY(0));
        vertex(getFaultX(0),getFaultY(40));
        vertex(getFaultX(28.2843),getFaultY(68.2843));
        vertex(getFaultX(46.6554),getFaultY(49.9131));
        vertex(getFaultX(25.9808),getFaultY(29.2384));
        vertex(getFaultX(25.9808),getFaultY(0));
        endShape();
        fill(255);
       break; 
    }
    stroke(0);
  }
  
}

void initializeLine() {
  flagFirstPt = 1;
  pX1 = 0;
  pX2 = 0;
  pY1 = 600;
  pY2 = 600;
}

void drawAllPlots() {
  if(ssNSS == 0) {
    drawSSplots();
  }
  else {
    drawNSSplots();
  }
}

void drawSSplots() {
  String fn;
  float[] Xpts = new float[101];
  float[] Ypts = new float[101];
  for(int i=0;i<6;i++) {
    if(selCase == 6 && i == 1) {
      continue;
    }
    fn = ssNames[selCase-1]+"_"+T[selT-1]+"_"+ssModels[i]+".txt";
    data = new FloatTable(fn);
    Xpts = getXpts();
    Ypts = getYpts();
    plotGraph(i,Xpts,Ypts);
  }
}

void drawNSSplots() {
  String fn;
  float[] Xpts = new float[101];
  float[] Ypts = new float[101];
  for(int i=0;i<4;i++) {
    fn = nssNames[selCase-1]+"_"+T[selT-1]+"_"+nssModels[i]+".txt";
    data = new FloatTable(fn);
    Xpts = getXpts();
    Ypts = getYpts();
    plotGraph(i,Xpts,Ypts);
  }
}

float[] getXpts() {
  float[] Xpt = new float[101];
  for(int i =0; i<101; i++) {
    Xpt[i] = 500+i*500/100;
  }
  return Xpt;
}

float[] getYpts() {
  float[] lX = new float[101];
  float[] lY = new float[101];
  float[] lXscreen = new float[101];
  float[] lYscreen = new float[101];
  float[] Ypt = new float[101];
  float dX = (pX2-pX1)/100;
  float Y1 = pY1;
  float dY = (pY2-pY1)/100;

  for(int i = 0; i<101; i++) {
    lXscreen[i] = pX1 + i*dX;
    lYscreen[i] = pY1 + i*dY;
  }

  lX = mapSc2RealX(lXscreen);
  lY = mapSc2RealY(lYscreen);
  int caseNo;
  if(ssNSS == 0) {
    caseNo = selCase-1;
  }
  else {
    caseNo = 6 + selCase -1;
  }

  float y1,y2,y3,y4,d1,d2,d3,d4;
  int l = ymax[caseNo]-ymin[caseNo] + 1;
  for(int i=0; i<101; i++) {
    y1 = data.getFloat(l*(ceil(lX[i])-xmin[caseNo])+(ceil(lY[i])-ymin[caseNo]),2);
    y2 = data.getFloat(l*(ceil(lX[i])-xmin[caseNo])+(floor(lY[i])-ymin[caseNo]),2);
    y3 = data.getFloat(l*(floor(lX[i])-xmin[caseNo])+(ceil(lY[i])-ymin[caseNo]),2);
    y4 = data.getFloat(l*(floor(lX[i])-xmin[caseNo])+(floor(lY[i])-ymin[caseNo]),2);

    d1 = sqrt(pow((ceil(lX[i])-lX[i]),2) + pow((ceil(lY[i])-lY[i]),2))+0.001;
    d2 = sqrt(pow((ceil(lX[i])-lX[i]),2) + pow((floor(lY[i])-lY[i]),2))+0.001;
    d3 = sqrt(pow((floor(lX[i])-lX[i]),2) + pow((ceil(lY[i])-lY[i]),2))+0.001;
    d4 = sqrt(pow((floor(lX[i])-lX[i]),2) + pow((floor(lY[i])-lY[i]),2))+0.001;
    if(i == 0){
      print(" x = " + lY[i] + " xx = " +  data.getFloat(l*(floor(lX[i])-xmin[caseNo])+(floor(lY[i])-ymin[caseNo]),1)); 
    }
    Ypt[i] = (y1*(1/d1)+y2*(1/d2)+y3*(1/d3)+y4*(1/d4))/((1/d1)+(1/d2)+(1/d3)+(1/d4));
  }
  return Ypt;
}

float[] mapSc2RealX(float[] Xsc) {
  float[] Xreal = new float[101];
  int caseNo;
  if(ssNSS == 0) {
    caseNo = selCase -1 ;
  }
  else {
    caseNo = 6 + selCase -1 ;
  }
  for(int i =0; i<101; i++) {
    Xreal[i] = xmin[caseNo] + (Xsc[i]/500)*(xmax[caseNo]-xmin[caseNo]);
  }
  return Xreal;
}

float[] mapSc2RealY(float[] Ysc) {
  float[] Yreal = new float[101];
  int caseNo;
  float Y;
  if(ssNSS == 0) {
    caseNo = selCase -1;
  }
  else {
    caseNo = 6 + selCase -1;
  }
  for(int i =0; i<101; i++) {
    Y = 600-Ysc[i];
    Yreal[i] = ymin[caseNo]+ (Y/400)*(ymax[caseNo]-ymin[caseNo]);
  }
  return Yreal;
}
/*
void plotGraph_old(int i,float[] Xpts,float[] Ypts) {
  int nCases;
  float dW; 
  if(ssNSS == 0) {
    nCases = 6;
    dW = 600/6;
  }
  else {
    nCases = 4;
    dW = 600/4;
  }
  stroke(#5679C1);
  noFill();
  strokeWeight(2);
  beginShape();
  for(int j =0; j< 101; j++) {
    vertex(Xpts[j],100+i*dW+dW-(Ypts[j]/2)*dW);
  }
  endShape();
  strokeWeight(1);
}
*/
void plotGraph(int i,float[] Xpts,float[] Ypts) {
  if(ssNSS == 0) {
    stroke(ssR[i],ssG[i],ssB[i]);
  }
  else {
    stroke(nssR[i],nssG[i],nssB[i]);
  }
  
  noFill();
  strokeWeight(2);
  beginShape();
  for(int j =0; j< 101; j++) {
    vertex(Xpts[j],600-(Ypts[j]*200));
  }
  endShape();
  strokeWeight(1);
}

