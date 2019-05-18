/*
16/05/2019
Basic design Created, which will perform basic functionalities for the drone RC.
It cannot be plugged to the RC of drone.
This file might receive just on update in future.Update will consist:
1)Remove all extra unsused or unnecessary code
Next Update will be in Drone_design, which will be plugable to the actual RC.
*/
/////////////////////////////////////////////////////////////Global Variables/////////////////////////////////////////////////
float mw;
int fontSize = 15;
int rectSize = 80;     // Diameter of rect
int power = 100;
int thrt_pow = 75;

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

Thrust rot0 = new Thrust(rot_x, rot_y, "Thrust", thrt_val);
Thrust rot1 = new Thrust(rot1_x, rot1_y, "Rotor 1", thrt_val_1);    //  ccw rotors
Thrust rot2 = new Thrust(rot2_x, rot2_y, "Rotor 2", thrt_val_2);    //  cw rotors
Thrust rot3 = new Thrust(rot3_x, rot3_y, "Rotor 3", thrt_val_3);    //  cw rotors
Thrust rot4 = new Thrust(rot4_x, rot4_y, "Rotor 4", thrt_val_4);    //  ccw rotors

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////Variables for Battery Class///////////////////////////////////////////////////

float vlt1=11.1,vlt2=7.5;
int bat1_pos_x, bat1_pos_y,bat2_pos_x,bat2_pos_y;
int batLen = 100,batWid = 25; 

/////////////////////////////////////////////////Constructor for Battery Class////////////////////////////////////////////////

Battery bt1 = new Battery(vlt1,bat1_pos_x,bat1_pos_y,"Main",11.1);
Battery bt2 = new Battery(vlt2,bat2_pos_x,bat2_pos_y,"2nd",9);

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

  rot0.drawShape(rectSize, rectCol, rot0.thrst,rot0.name);
  rot1.drawShape(rectSize, rectCol, rot1.thrst,rot1.name);
  rot2.drawShape(rectSize, rectCol, rot2.thrst,rot2.name);
  rot3.drawShape(rectSize, rectCol, rot3.thrst,rot3.name);
  rot4.drawShape(rectSize, rectCol, rot4.thrst,rot4.name);

  bt1.drawBat(batLen,batWid,bt1.name);
  bt2.drawBat(batLen,batWid,bt2.name);
 
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
}
void mouseWheel(MouseEvent event){  mw = event.getCount();  }

void movement(Thrust t1, Thrust t2)
{
  int flank = rot0.getThrust()-power;
  t1.stThrst(flank);
  t2.stThrst(flank);
  //text(flank,100,100);
}
void movement(Thrust t1, Thrust t2,Thrust t3,Thrust t4,int th)
{
  t1.stThrst(th);
  t2.stThrst(th);
  t3.stThrst(th);
  t4.stThrst(th);
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
    fill(0);
    stroke(255);
    rect(pos_x, pos_y, len, br, curve);
    textAlign(CENTER, CENTER);
    fill(255);
    text(name, pos_x+(rectSize/2), pos_y-fontSize);
    text(thrst_val, pos_x+(rectSize/2), pos_y+rectCol+(rectSize/1.5));
  }
  void drawRect(int len, int br)
  {
    stroke(255);
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
class Thrust extends Shape
{
  int pos_x, pos_y;
  String name;
  int thrst, thrst_dir, thrst1;
  boolean clickp = false, clickm = false;

  Thrust(int pos_x, int pos_y, String name, int thrst)
  {
    this.pos_x = pos_x;
    this.pos_y = pos_y;
    this.name = name;
    this.thrst = thrst;
  }
  int getThrust(){return thrst;}
  void setThrust(int thrst)
  {
    if(this.thrst>=1000 && this.thrst<=2000)
      this.thrst += thrst/10;
    if(this.thrst>=2000)
      this.thrst = 2000;
    if(this.thrst<=1000)
      this.thrst = 1000;
  }
  void stThrst(int thrst)  
  {
    if(this.thrst>=1000 && this.thrst<=2000)
      this.thrst = thrst + thrst_dir;
    if(this.thrst>=2000)
      this.thrst = 2000;
    if(this.thrst<=1000)
      this.thrst = 1000;
  }
  void drawShape(int len, int br, int thrst,String name)
  {  
    fill(0);
    circle(super.pos_x+(rectSize/2), super.pos_y+rectCol+(rectSize/1.5), rectSize);  //Thrust display circle
    fill(255);
    super.drawRect(len, br, 7, thrst,name);
    dispThrust(thrst);
    dispThrustControl();
  }
  void dispThrust(int thrst)
  {
    fill(0,0,255);
    noStroke();
    float i;
    for(i=100; i<(thrst/5)-105;i+=5)
      rect(super.pos_x+2,super.pos_y+(1.5*rectCol)-i-7,.96*rectSize,(rectCol/20)-5.75,1);
    stroke(255);
  }
  void dispThrustControl()
  {
    thrst1 = thrst;
    int inr_size = rectSize/3;
    int inr_x = super.pos_x+(rectSize)+inr_size/2;
    int inr_y = super.pos_y+rectCol+(rectSize/4);
    super.btnClick(inr_x,inr_y,inr_size,inr_size,this,thrt_pow);
    rect(inr_x,inr_y , inr_size,inr_size);  //Thrust display circle
    fill(255);
    text("+",inr_x+(inr_size/2),inr_y+(inr_size/2.5));  //Thrust display circle
    super.btnClick(inr_x,int(inr_y+(1.25*inr_size)),inr_size,inr_size,this,-thrt_pow);
    rect(inr_x, inr_y+1.25*inr_size, inr_size,inr_size);  //Thrust display circle
    fill(255);
    text("-",inr_x+(inr_size/2),inr_y+1.6*inr_size);  //Thrust display circle
    thrst_dir += thrst - thrst1;
    text(thrst_dir,super.pos_x-2,super.pos_y+(1.5*rectCol));
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////This is the Battery Class///////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Battery extends Shape
{
  float volt,max;
  int pos_x, pos_y;
  String name;
  Battery(float volt,int pos_x,int pos_y,String name,float max)
  {
    this.volt = volt;
    this.pos_x = pos_x;
    this.pos_y = pos_y;
    this.name = name;
    this.max = max;
  }
  void drawBat(int len, int br, String name)                //////////Draws the Button from the Base Class Shape////////////
  {    
    fill(0);
    super.drawRect(len, br);                            //////////Calls the drawRect() method of base class/////////////
    fill(255);
    textAlign(LEFT,CENTER);
    text(name, super.pos_x-1.75*batWid, super.pos_y,batWid*2,batWid);
    dispVolt();
  }
  void dispVolt()
  {
    fill(0);
    rect(super.pos_x, super.pos_y, batLen+1, batWid,3);
    fill(0,175,0);
    float j = 0.5;
    float per = (volt/max)*100;
    noStroke();
    for(float i = 0; i<per; i+=0.8)
      rect(super.pos_x+i+1, super.pos_y+1, 1, batWid-2,3);
    stroke(255);
    fill(255);
    textAlign(LEFT,BOTTOM);
    text("Volts="+volt+"v",super.pos_x,super.pos_y);
    textAlign(CENTER,CENTER);
    text(nf(per,0,1)+"%",super.pos_x,super.pos_y,batLen,batWid);
  }
}
