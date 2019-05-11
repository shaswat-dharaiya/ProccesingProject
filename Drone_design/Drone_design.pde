int rectX_thrst, rectY_thrst;      // Position of square button
int rectX_hld, rectY_hld;      // Position of square button
int rectX_lnd, rectY_lnd;      // Position of square button
int rectX_role_r, rectY_role_r;      // Position of square button
int rectX_role_l, rectY_role_l;      // Position of square button
int rectX_ptch_fwd, rectY_ptch_fwd;      // Position of square button
int rectX_ptch_bkd, rectY_ptch_bkd;      // Position of square button
int rectX_yaw_cw, rectY_yaw_cw;      // Position of square button
int rectX_yaw_ccw, rectY_yaw_ccw;      // Position of square button

int rectSize = 75;     // Diameter of rect

RectDraw thrst = new RectDraw(rectX_thrst, rectY_thrst, "Thrust",'8');
RectDraw hld = new RectDraw(rectX_hld, rectY_hld, "Hold",' ');
RectDraw lnd = new RectDraw(rectX_lnd, rectY_lnd, "Land",'5');
RectDraw role_l = new RectDraw(rectX_role_r, rectY_role_r, "Role Left",'a');
RectDraw role_r = new RectDraw(rectX_role_l, rectY_role_l, "Role Right",'d');
RectDraw ptch_fwd = new RectDraw(rectX_ptch_fwd, rectY_ptch_fwd, "Forward",'w');
RectDraw ptch_bkd = new RectDraw(rectX_ptch_bkd, rectY_ptch_bkd, "Backward",'s');
RectDraw yaw_cw = new RectDraw(rectX_yaw_cw, rectY_yaw_cw, "Yaw +",'4');
RectDraw yaw_ccw = new RectDraw(rectX_yaw_ccw, rectY_yaw_ccw, "Yaw -",'6');

int rectCol = 200;
int rectBar = 5;

int rot1_x, rot1_y;
int rot2_x, rot2_y;
int rot3_x, rot3_y;
int rot4_x, rot4_y;

int thrt_val_1=1000,thrt_val_2=2000,thrt_val_3=1500,thrt_val_4=1200; 

Thrust rot1 = new Thrust(rot1_x,rot1_y,"Rotor 1",thrt_val_1);
Thrust rot2 = new Thrust(rot2_x,rot2_y,"Rotor 2",thrt_val_2);
Thrust rot3 = new Thrust(rot3_x,rot3_y,"Rotor 3",thrt_val_3);
Thrust rot4 = new Thrust(rot4_x,rot4_y,"Rotor 4",thrt_val_4);

float vlt2=4.5, vlt1=11.1;
int bat1_pos_x, bat1_pos_y,bat2_pos_x,bat2_pos_y;
int batLen = 100,batWid = 20; 

Battery bt1 = new Battery(vlt1,bat1_pos_x,bat1_pos_y,"Main",11.1);
Battery bt2 = new Battery(vlt2,bat2_pos_x,bat2_pos_y,"Side",9);

void setup() {
  size(1600, 1000);

  thrst.posRect(500, 0);
  hld.posRect(300, 200);
  lnd.posRect(500, 150);
  role_l.posRect(0, 75);
  role_r.posRect(200, 75);
  ptch_fwd.posRect(100, 0);
  ptch_bkd.posRect(100, 150);
  yaw_cw.posRect(400, 75);
  yaw_ccw.posRect(600, 75);
  
  rot1.rotDraw(150,0);
  rot2.rotDraw(300,175);
  rot3.rotDraw(0,175);
  rot4.rotDraw(150,325);
  
  bt1.batDraw(0);
  bt2.batDraw(40);
  
}
void draw() {
  background(102);  
  thrst.drawRect();
  hld.drawRect();
  lnd.drawRect();
  role_l.drawRect();
  role_r.drawRect();
  ptch_fwd.drawRect();
  ptch_bkd.drawRect();
  yaw_cw.drawRect();
  yaw_ccw.drawRect();
  
  rot1.rotShape();
  rot2.rotShape();
  rot3.rotShape();
  rot4.rotShape();
  
  bt1.batShape();
  bt2.batShape();
}
class RectDraw
{
  int rec_x, rec_y;
  String name;
  char dir;
  RectDraw(int rec_x, int rec_y, String name,char dir)
  {
    this.rec_x = rec_x;
    this.rec_y = rec_y;
    this.name = name;
    this.dir = dir;
  }
  void drawRect()
  {
    fill(0);
    if ((mouseX >= rec_x && mouseX <= (rec_x+rectSize) && mouseY >= rec_y && mouseY <= (rec_y+rectSize)) || ( keyPressed == true && key == dir))
    {
      fill(50);
    }
    rect(rec_x, rec_y, rectSize, rectSize,7);
    update();
  }
  void posRect(int i, int j)
  {
    rec_x = (width/20)+i;
    rec_y = (height/20)+j;
  }
  void update() {
    fill(255);
    if ((mouseX >= rec_x && mouseX <= (rec_x+rectSize) && mouseY >= rec_y && mouseY <= (rec_y+rectSize)) || ( keyPressed == true && key == dir))
    {
      fill(200);
    }
      text(name, rec_x+4, rec_y+2,rectSize-10,rectSize-10);
      textAlign(CENTER,CENTER);
      stroke(255);
  }
}

class Thrust
{
  int pos_x,pos_y;
  String rot;
  int val;
  Thrust(int pos_x, int pos_y,String rot,int val)
  {
    this.pos_x = pos_x;
    this.pos_y = pos_y;
    this.rot = rot;
    this.val = val;
  }
  void rotShape()
  {
    fill(0);
    rect(pos_x, pos_y, rectSize, rectCol,3);
    circle(pos_x+35,pos_y+rectCol+rectSize-30,rectSize);
    fill(0,0,235);
    int thrst_y = pos_y+rectCol+94;
    float i;
    for(i = 100; i<(val/5)-105; i+=5)
    {
      noStroke();
      rect(pos_x+2, thrst_y-i, rectSize-4, 1*(rectBar)-1,1);
    }
    stroke(255);
    fill(255);
    text(rot,pos_x+35,pos_y-10);
    text(val,pos_x+35,pos_y+rectCol+rectSize-30);
    textAlign(CENTER,CENTER);
  }
  void rotDraw(int i, int j)
  {
    pos_x = (14*width/20)+i;
    pos_y = (height/20)+j;
  }
}
class Battery
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
  void batShape()
  {
    fill(0);
    rect(pos_x, pos_y, batLen+1, batWid,3);
    
    fill(0,255,0);
    float j = 0.5;
    float per = (volt/max)*100;
    for(float i = 0; i<per; i+=0.8)
    {
      noStroke();
      rect(pos_x+i+1, pos_y+1, 1, batWid-2,3);
    }
    stroke(255);
    fill(255);
    text(name,pos_x-30,pos_y-10);
    text("V ="+volt+"v",pos_x-30,pos_y+7);
    text("Bat = "+nf(per,0,2)+"%",pos_x+50,pos_y-10);
    textAlign(CENTER,CENTER);
  }
  void batDraw(int i)
  {
    pos_x = 23*width/25;
    pos_y = (height/40)+i;
  }
}
