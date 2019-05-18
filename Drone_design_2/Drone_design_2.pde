/*
18/05/2019
System still in design & development.
The incomming string will carry the MPU data,Battery Voltage, and Rotors thrust.
Rotor data and Battery voltage is derived from incomming string and implemented in design, mpu data is yet to be implemented.
No bugs yet
Code is pluggable
Next Update:
1)Implement Mpu data in design.
2)Adjust the thrust according to MPU data.
3)Make Code plugable.

The actual pluggable design of RC will be in Drone_design_pluggable.
*/

/////////////////////////////////////////////////////////////Global Variables/////////////////////////////////////////////////
float mw,valF;
int fontSize = 15;
int rectSize = 80;     // Diameter of rect
int power = 100;
int thrt_pow = 50;
String incommingString = "1.23:4.56:7.89:0.12:3.45:6.78:V11.1:7.8:T1500:2000:1400:1200:;";
String outgoingString;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////Variables for ControlButtons Class////////////////////////////////////////////

int rectX_thrst, rectY_thrst;      // Position of square button
int rectX_hld, rectY_hld;      // Position of square button
int rectX_lnd, rectY_lnd;      // Position of square button
int rectX_role_r, rectY_role_r;      // Position of square button
int rectX_role_l, rectY_role_l;      // Position of square button
int rectX_ptch_fwd, rectY_ptch_fwd;      // Position of square button
int rectX_ptch_bkd, rectY_ptch_bkd;      // Position of square button
int rectX_yaw_cw, rectY_yaw_cw;      // Position of square button
int rectX_yaw_ccw, rectY_yaw_ccw;      // Position of square button

//////////////////////////////////////////////////Constructor for ControlButtons Class////////////////////////////////////////

ControlButtons thrst = new ControlButtons(rectX_thrst, rectY_thrst, "Lift", 'w');
ControlButtons lnd = new ControlButtons(rectX_lnd, rectY_lnd, "Drop", 's');
ControlButtons role_l = new ControlButtons(rectX_role_r, rectY_role_r, "Role Left", '4');
ControlButtons role_r = new ControlButtons(rectX_role_l, rectY_role_l, "Role Right", '6');
ControlButtons ptch_fwd = new ControlButtons(rectX_ptch_fwd, rectY_ptch_fwd, "Forward", '8');
ControlButtons ptch_bkd = new ControlButtons(rectX_ptch_bkd, rectY_ptch_bkd, "Backward", '5');
ControlButtons yaw_cw = new ControlButtons(rectX_yaw_cw, rectY_yaw_cw, "Yaw +", 'a');
ControlButtons yaw_ccw = new ControlButtons(rectX_yaw_ccw, rectY_yaw_ccw, "Yaw -", 'd');
//ControlButtons hld = new ControlButtons((rectX_hld, rectY_hld, "Hold",' ');

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////Variables for Thrust Class////////////////////////////////////////////////////

int rectCol = 200;
int rot1_x, rot1_y;
int rot2_x, rot2_y;
int rot3_x, rot3_y;
int rot4_x, rot4_y;
int rot_x, rot_y;
int thrt_val_1=1000, thrt_val_2=1000, thrt_val_3=1000, thrt_val_4=1000, thrt_val=1000, prev_val;

/////////////////////////////////////////////////Constructor for Thrust Class/////////////////////////////////////////////////

Thrust rot0 = new Thrust(rot_x, rot_y, "Thrust", thrt_val,0);
Thrust rot1 = new Thrust(rot1_x, rot1_y, "Rotor 1", thrt_val_1,0);    //  ccw rotors
Thrust rot2 = new Thrust(rot2_x, rot2_y, "Rotor 2", thrt_val_2,1);    //  cw rotors
Thrust rot3 = new Thrust(rot3_x, rot3_y, "Rotor 3", thrt_val_3,2);    //  cw rotors
Thrust rot4 = new Thrust(rot4_x, rot4_y, "Rotor 4", thrt_val_4,3);    //  ccw rotors

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////Variables for Battery Class///////////////////////////////////////////////////

float vlt1,vlt2;
int bat1_pos_x, bat1_pos_y,bat2_pos_x,bat2_pos_y;
int batLen = 100,batWid = 25; 

/////////////////////////////////////////////////Constructor for Battery Class////////////////////////////////////////////////

Battery bt1 = new Battery(vlt1,bat1_pos_x,bat1_pos_y,"Main",11.1,0);
Battery bt2 = new Battery(vlt2,bat2_pos_x,bat2_pos_y,"2nd",9,1);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////Variables for MPU Class////////////////////////////////////////////////////

int mpuBox = 500;

///////////////////////////////////////////////////Constructor for MPU Class//////////////////////////////////////////////////

MPU mpu = new MPU();//incommingString);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////This is the Setup Method()////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void setup() {
  size(1600, 1000);
  smooth();
  thrst.posRect(rectSize+10, 0);
  lnd.posRect(rectSize+10, 2*(rectSize+10));
  yaw_cw.posRect(0, rectSize+10);
  yaw_ccw.posRect(2*(rectSize+10), rectSize+10);
  ptch_fwd.posRect(5*rectSize+10, 0);
  ptch_bkd.posRect(5*rectSize+10, 2*(rectSize+10));
  role_l.posRect(4*rectSize, rectSize+10);
  role_r.posRect(6*rectSize+20, rectSize+10); 
  //hld.posRect(300, 200);
  int i = 13;
  rot0.posRect(((i+4)*width/20), rectCol);
  rot1.posRect((i*width/20), 0);
  rot2.posRect(((i+2)*width/20), 0);
  rot4.posRect((i*width/20), 2*rectCol);
  rot3.posRect(((i+2)*width/20), 2*rectCol);
  
  bt1.posRect((17*width/20)+batWid,(-batWid/2));
  bt2.posRect((17*width/20)+batWid,int(1.5*batWid));
  
  mpu.posRect(2*height/20,7*height/20);
  
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////This is the Draw Method()/////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void draw() {
  background(102); 
  textSize(fontSize);
  thrst.drawShape(rectSize, rectSize);
  //hld.drawShape(rectSize);
  lnd.drawShape(rectSize, rectSize);
  role_l.drawShape(rectSize, rectSize);
  role_r.drawShape(rectSize, rectSize);
  ptch_fwd.drawShape(rectSize, rectSize);
  ptch_bkd.drawShape(rectSize, rectSize);
  yaw_cw.drawShape(rectSize, rectSize);
  yaw_ccw.drawShape(rectSize, rectSize);

  rot0.setReadString("T"+rot0.getThrust()+":");
  rot1.setReadString(incommingString);
  rot2.setReadString(incommingString);
  rot3.setReadString(incommingString);
  rot4.setReadString(incommingString);  
  
  rot0.drawShape(rectSize, rectCol, rot0.out_thrstValue,rot0.name);
  rot1.drawShape(rectSize, rectCol, rot1.in_thrstValue,rot1.name);
  rot2.drawShape(rectSize, rectCol, rot2.in_thrstValue,rot2.name);
  rot3.drawShape(rectSize, rectCol, rot3.in_thrstValue,rot3.name);
  rot4.drawShape(rectSize, rectCol, rot4.in_thrstValue,rot4.name);

  bt1.setReadString(incommingString);
  bt2.setReadString(incommingString);
  bt1.drawBat(batLen,batWid,bt1.name);
  bt2.drawBat(batLen,batWid,bt2.name);
  
  fill(0);
  mpu.drawRect(mpuBox,mpuBox);
  mpu.setReadString(incommingString);
  mpu.dispReadString();
  
  if(keyPressed || mousePressed)
  {
    if(thrst.btnClicked())
    {
      rot0.setThrust(thrt_pow);
      movement(rot1,rot2,rot3,rot4,rot0.getThrust());
    }
    if(lnd.btnClicked())
    {
      rot0.setThrust(-thrt_pow);
      movement(rot1,rot2,rot3,rot4,rot0.getThrust());
    }
    if(ptch_fwd.btnClicked())
      movement(rot1,rot2);
    if(ptch_bkd.btnClicked())
      movement(rot3,rot4);
    if(role_r.btnClicked())
      movement(rot2,rot3);
    if(role_l.btnClicked())
      movement(rot1,rot4);
    if(yaw_cw.btnClicked())
      movement(rot1,rot3);
    if(yaw_ccw.btnClicked())
      movement(rot2,rot4);      
  }    
  else
    movement(rot1,rot2,rot3,rot4,rot0.getThrust());
    
  outgoingString = renderOutputString();
}
void mouseWheel(MouseEvent event){  mw = event.getCount();  }

void movement(Thrust t1, Thrust t2)
{
  int flank = rot0.getThrust()-power;
  t1.stThrst(flank);
  t2.stThrst(flank);
}
void movement(Thrust t1, Thrust t2,Thrust t3,Thrust t4,int th)
{
  t1.stThrst(th);
  t2.stThrst(th);
  t3.stThrst(th);
  t4.stThrst(th);
}
String renderOutputString()
{
  String outputString;
  outputString = rot1.getThrust()+":"+rot2.getThrust()+":"+rot3.getThrust()+":"+rot4.getThrust();
  return outputString;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////This is the Base Shape Class/////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Shape
{
  int pos_x, pos_y;
  int i, j;
  void posRect(int i, int j)
  {
    pos_x = (width/20)+i;
    pos_y = (height/20)+j;
  }
  void drawRect(int len, int br, int curve, int thrst_val, String name)
  {
    stroke(0);
    rect(pos_x, pos_y, len, br, curve);
    textAlign(CENTER, CENTER);
    fill(255);
    text(name, pos_x+(rectSize/2), pos_y-fontSize);
    text(thrst_val, pos_x+(rectSize/2), pos_y+rectCol+(rectSize/1.5));
  }
  void drawRect(int len, int br)
  {
    stroke(0);
    rect(pos_x, pos_y, len, br, 7);
  }
  void btnClick(int x_cord, int y_cord, int x_range,int y_range,Thrust t,int inr)
  {
    fill(0);
    if (mouseX >= x_cord && mouseX <= x_cord+x_range && mouseY >= y_cord && mouseY <= y_cord+y_range)
      fill(50);
    if ((mouseX >= x_cord && mouseX <= x_cord+x_range && mouseY >= y_cord && mouseY <= y_cord+y_range && mousePressed == true))
    {
      fill(100);
      t.setThrust(inr);
    }
  }
  boolean btnClick(int x_cord, int y_cord, int range,char dir)
  {
    boolean clicked = false;
    fill(0);
    if (mouseX >= x_cord && mouseX <= x_cord+range && mouseY >= y_cord && mouseY <= y_cord+range)
      fill(50);
    if ((mouseX >= x_cord && mouseX <= x_cord+range && mouseY >= y_cord && mouseY <= y_cord+range && mousePressed == true) || ( keyPressed == true && key == dir))
    {
      clicked = true;
      fill(100);
    }
    return clicked;
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////This is the Control Button Class/////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ControlButtons extends Shape
{
  int pos_x, pos_y;
  String name;
  char dir;
  int i, j, len, br;
  boolean clicked;
  ControlButtons(int pos_x, int pos_y, String name, char dir)  /////////Only Constructor of the ControlButton Class///////////
  {
    this.pos_x = pos_x;
    this.pos_y = pos_y;
    this.name = name;
    this.dir = dir;
  }
  char getDir(){return dir;}                                  ////////Returns the char assigned to the Button/////////////////
  
  void drawShape(int len, int br)                //////////Draws the Button from the Base Class Shape////////////
  {   
    clicked = super.btnClick(super.pos_x,super.pos_y,rectSize,dir);     //////////Calls the btnClick() method of base class///////////// 
    super.drawRect(len, br);                            //////////Calls the drawRect() method of base class/////////////
    textAlign(CENTER, CENTER);
    fill(255);
    text(name, super.pos_x, super.pos_y-(rectSize/16), rectSize, rectSize);
  }
  boolean btnClicked()
  {
    if(clicked)
      return true;
    else
      return false;
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////This is the Thrust Class////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
  All the out_thrstValue will be serialized 
  and appended to the outgoing string and will 
  be transmitted over.
  
  The incomming string will be deserialized
  and the data will be to an array of float
  in renderReadBuffer() method and the rotIndex
  will provide index of each rotor.
*/
class Thrust extends Shape
{
  int pos_x, pos_y;
  String name, readBuffer;
  int thrst_dir, thrst1, rotIndex, prev_index;   
  int in_thrstValue;                 //////////in_thrstValue is the thrust value which is  received from the drone////////////
  int out_thrstValue;                //////////out_thrstValue is the thrust value which is to be sent to the drone////////////
  boolean clickp = false, clickm = false;
  
  Thrust(int pos_x, int pos_y, String name, int out_thrstValue,int rotIndex)
  {
    this.pos_x = pos_x;
    this.pos_y = pos_y;
    this.name = name;
    this.out_thrstValue = out_thrstValue;
    this.rotIndex = rotIndex;
  }
  String getReadString(){return readBuffer;}
  void setReadString(String readBuffer){this.readBuffer = readBuffer;}
  int getThrust(){return out_thrstValue;}
  void setThrust(int out_thrstValue)
  {
    if(this.out_thrstValue>=1000 && this.out_thrstValue<=2000)
      this.out_thrstValue += out_thrstValue/10;
    if(this.out_thrstValue>=2000)
      this.out_thrstValue = 2000;
    if(this.out_thrstValue<=1000)
      this.out_thrstValue = 1000;
  }
  void stThrst(int out_thrstValue)  
  {
    if(this.out_thrstValue>=1000 && this.out_thrstValue<=2000)
      this.out_thrstValue = out_thrstValue + thrst_dir;
    if(this.out_thrstValue>=2000)
      this.out_thrstValue = 2000;
    if(this.out_thrstValue<=1000)
      this.out_thrstValue = 1000;
  }
  void drawShape(int len, int br, int in_thrstValue,String name)
  {  
    fill(0);
    circle(super.pos_x+(rectSize/2), super.pos_y+rectCol+(rectSize/1.5), rectSize);  //Thrust display circle
    super.drawRect(len, br, 7, in_thrstValue, name);
    dispThrust(in_thrstValue);
    dispThrustControl();
  }
  void dispThrust(int in_thrstValue)
  {
    fill(0,0,255);
    noStroke();
    float i;
    for(i=100; i<(in_thrstValue/5)-105;i+=5)
      rect(super.pos_x+2,super.pos_y+(1.5*rectCol)-i-7,.96*rectSize,(rectCol/20)-5.75,1);
    stroke(50);
  }
  void dispThrustControl()
  {
    textAlign(CENTER,CENTER);
    int inr_pow = 10;
    int[] rotValues = renderReadBuffer(readBuffer);
    in_thrstValue = rotValues[rotIndex]; 
    thrst1 = out_thrstValue;
    int inr_size = rectSize/3;
    int inr_x = super.pos_x+(rectSize)+inr_size/2;
    int inr_y = super.pos_y+rectCol+(rectSize/4);
    super.btnClick(inr_x,inr_y,inr_size,inr_size,this,inr_pow);
    rect(inr_x,inr_y , inr_size,inr_size);  //Thrust display circle
    fill(255);
    text("+",inr_x,inr_y,inr_size,inr_size-5);  //Thrust display circle
    super.btnClick(inr_x,int(inr_y+(1.25*inr_size)),inr_size,inr_size,this,-inr_pow);
    rect(inr_x, inr_y+1.25*inr_size, inr_size,inr_size);  //Thrust display circle
    fill(255);
    text("-",inr_x,inr_y+1.25*inr_size,inr_size,inr_size-5);  //Thrust display circle
    thrst_dir += out_thrstValue - thrst1;
    text(out_thrstValue,super.pos_x-2,super.pos_y+(1.5*rectCol));
  }
  int[] renderReadBuffer(String readBufferString)
  {
    String readString,bufferString;
    int index = readBufferString.indexOf('T');
    readString = readBufferString.substring(index);
    index = readString.indexOf('T');
    int len = (readString.length()-1)/5;
    int[] rotValues = new int[len];
    for(int i=0;i<len;i++)
    {
      prev_index = index+1;
      index = readString.indexOf(':',prev_index);
      bufferString = readString.substring(prev_index,index);
      rotValues[i] = int(bufferString);
    }
    return rotValues;
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////This is the Battery Class///////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Battery extends Shape
{
  float volt,max;
  int pos_x, pos_y,batIndex,prev_index;
  String name,readBuffer;
  Battery(float volt,int pos_x,int pos_y,String name,float max,int batIndex)
  {
    this.volt = volt;
    this.pos_x = pos_x;
    this.pos_y = pos_y;
    this.name = name;
    this.max = max;
    this.batIndex = batIndex;
  }
  String getReadString(){return readBuffer;}
  void setReadString(String readBuffer){this.readBuffer = readBuffer;}
  void drawBat(int len, int br, String name)                //////////Draws the Button from the Base Class Shape////////////
  {    
    fill(0);
    super.drawRect(len, br);                                //////////Calls the drawRect() method of base class/////////////
    fill(255);
    textAlign(LEFT,CENTER);
    text(name, super.pos_x-1.75*batWid, super.pos_y,batWid*2,batWid);
    dispVolt();
  }
  void dispVolt()
  {
    float[] batValues = renderReadBuffer(readBuffer);
    volt = batValues[batIndex];
    fill(0);
    rect(super.pos_x, super.pos_y, batLen+1, batWid,3);
    fill(0,175,0);
    float j = 0.5;
    float per = (volt/max)*100;
    noStroke();
    for(float i = 0; i<per; i+=0.8)
      rect(super.pos_x+i+1, super.pos_y+1, 1, batWid-1,3);
    fill(255);
    textAlign(LEFT,BOTTOM);
    text("Volts="+volt+"v",super.pos_x,super.pos_y);
    textAlign(CENTER,CENTER);
    text(nf(per,0,1)+"%",super.pos_x,super.pos_y,batLen,batWid);
  }
  float[] renderReadBuffer(String readBufferString)
  {
    String readString = "";
    float[] batValues = new float[2];
    int index = readBufferString.indexOf('V');
    for(int i=0;i<batValues.length;i++)
    {
      prev_index = index+1;
      index = readBufferString.indexOf(':',index+1);
      readString = readBufferString.substring(prev_index,index);
      batValues[i] = float(readString);
    }
    return batValues;
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////This is the MPU Class///////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class MPU extends Shape
{
  int pos_x,pos_y;
  float X,Y,Z; 
  String readBuffer;
  MPU(){}
  void mpuSetX(float X){this.X = X;}
  void mpuSetY(float Y){this.Y = Y;}
  void mpuSetZ(float Z){this.Z = Z;}
  
  float mpuGetX(){return X;}
  float mpuGetY(){return Y;}
  float mpuGetZ(){return Z;}
  
  String getReadString(){return readBuffer;}
  void setReadString(String readBuffer){this.readBuffer = readBuffer;}
  void dispReadString()
  {
    fill(255);
    textAlign(CENTER,CENTER);
    //text(readBuffer,super.pos_x,super.pos_y,mpuBox,mpuBox);
    float[] mpuVal = renderReadBuffer(readBuffer);
    for(int i =1; i<mpuVal.length+1;i++)
      text(str(mpuVal[i-1]),super.pos_x,super.pos_y+(i*30)-(mpuBox/4),mpuBox,mpuBox);
  }
  float[] renderReadBuffer(String readBufferString)
  {
    String readString;
    float[] mpuValues = new float[6];
    int index = -1,prev_index;
    for(int i = 0;i<mpuValues.length;i++)
    {
      prev_index = index+1;
      index = readBufferString.indexOf(':',index+1);
      readString = readBufferString.substring(prev_index,index);
      mpuValues[i] = float(readString);
    }
    return mpuValues;
  }
  float[] setGyro(float[] mpu)
  {
    float[] gyroValues = new float[3];
    for(int i=0;i<mpu.length;i++)
      if(i<3) gyroValues[i] = mpu[i];
    return gyroValues;
  }
  float[] setAccel(float[] mpu)
  {
    float[] accelValues = new float[3];
    for(int i=0;i<mpu.length;i++)
      if(i>2) accelValues[i+3] = mpu[i];
    return accelValues;
  } 
}
class Gyroscope extends MPU
{
  float rX, rY, rZ;
  Gyroscope(float rX,float rY,float rZ)
  {
    this.rX = rX;
    this.rY = rY;
    this.rZ = rZ;
  }
  
}
class Accelerometer extends MPU
{
  float gFX, gFY, gFZ;
  Accelerometer(float gFX,float gFY,float gFZ)
  {
    this.gFX = gFX;
    this.gFY = gFY;
    this.gFZ = gFZ;
  }
}
