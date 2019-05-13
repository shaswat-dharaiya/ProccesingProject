int fontSize = 15;
float mw;
char keytyped;
int power = 100;
int thrt_pow = 40;

int rectX_thrst, rectY_thrst;      // Position of square button
int rectX_hld, rectY_hld;      // Position of square button
int rectX_lnd, rectY_lnd;      // Position of square button
int rectX_role_r, rectY_role_r;      // Position of square button
int rectX_role_l, rectY_role_l;      // Position of square button
int rectX_ptch_fwd, rectY_ptch_fwd;      // Position of square button
int rectX_ptch_bkd, rectY_ptch_bkd;      // Position of square button
int rectX_yaw_cw, rectY_yaw_cw;      // Position of square button
int rectX_yaw_ccw, rectY_yaw_ccw;      // Position of square button

int rectSize = 80;     // Diameter of rect

RectDraw thrst = new RectDraw(rectX_thrst, rectY_thrst, "Lift",'w');
//RectDraw hld = new RectDraw(rectX_hld, rectY_hld, "Hold",' ');
RectDraw lnd = new RectDraw(rectX_lnd, rectY_lnd, "Drop",'s');
RectDraw role_l = new RectDraw(rectX_role_r, rectY_role_r, "Role Left",'4');
RectDraw role_r = new RectDraw(rectX_role_l, rectY_role_l, "Role Right",'6');
RectDraw ptch_fwd = new RectDraw(rectX_ptch_fwd, rectY_ptch_fwd, "Forward",'8');
RectDraw ptch_bkd = new RectDraw(rectX_ptch_bkd, rectY_ptch_bkd, "Backward",'5');
RectDraw yaw_cw = new RectDraw(rectX_yaw_cw, rectY_yaw_cw, "Yaw +",'a');
RectDraw yaw_ccw = new RectDraw(rectX_yaw_ccw, rectY_yaw_ccw, "Yaw -",'d');

int rectCol = 200;
int rectBar = 5;

int rot1_x, rot1_y;
int rot2_x, rot2_y;
int rot3_x, rot3_y;
int rot4_x, rot4_y;
int rot_x, rot_y;

int thrt_val_1=1000,thrt_val_2=1000,thrt_val_3=1000,thrt_val_4=1000,thrt_val=1000,prev_val;

Thrust rot1 = new Thrust(rot1_x,rot1_y,"Rotor 1",thrt_val_1);
Thrust rot2 = new Thrust(rot2_x,rot2_y,"Rotor 2",thrt_val_2);
Thrust rot3 = new Thrust(rot3_x,rot3_y,"Rotor 3",thrt_val_3);
Thrust rot4 = new Thrust(rot4_x,rot4_y,"Rotor 4",thrt_val_4);

Thrust rot = new Thrust(rot_x,rot_y,"Thrust",thrt_val);

float vlt2=4.5, vlt1=11.1;
int bat1_pos_x, bat1_pos_y,bat2_pos_x,bat2_pos_y;
int batLen = 100,batWid = 20; 

Battery bt1 = new Battery(vlt1,bat1_pos_x,bat1_pos_y,"Main",11.1);
Battery bt2 = new Battery(vlt2,bat2_pos_x,bat2_pos_y,"Side",9);

void setup() {
  size(1600, 1000);
  smooth();

  ptch_fwd.posRect(500, 0);
  //hld.posRect(300, 200);
  ptch_bkd.posRect(500, 150);
  yaw_cw.posRect(0, 75);
  yaw_ccw.posRect(200, 75);
  thrst.posRect(100, 0);
  lnd.posRect(100, 150);
  role_l.posRect(400, 75);
  role_r.posRect(600, 75);
  
  rot1.rotDraw(150,0);
  rot2.rotDraw(300,175);
  rot4.rotDraw(0,175);
  rot3.rotDraw(150,325);
  
  rot.rotDraw(380-(14*width/20),0);
  
  bt1.batDraw(0);
  bt2.batDraw(40);
  
}
void draw() {
  background(102); 
  textSize(fontSize);
  thrst.drawRect();
  //hld.drawRect();
  lnd.drawRect();
  role_l.drawRect();
  role_r.drawRect();
  ptch_fwd.drawRect();
  ptch_bkd.drawRect();
  yaw_cw.drawRect();
  yaw_ccw.drawRect();
  
  if(keyPressed || mousePressed)
  {
    //keytyped = key;
    if(key == thrst.getDir() || (mouseX >= thrst.rec_x && mouseX <= (thrst.rec_x+rectSize) && mouseY >= thrst.rec_y && mouseY <= (thrst.rec_y+rectSize) && mousePressed == true))
      rot.setThrust(thrt_pow);
    if(key == lnd.getDir() || (mouseX >= lnd.rec_x && mouseX <= (lnd.rec_x+rectSize) && mouseY >= lnd.rec_y && mouseY <= (lnd.rec_y+rectSize) && mousePressed == true))
      rot.setThrust(-thrt_pow);
    if(key == ptch_fwd.getDir() || (mouseX >= ptch_fwd.rec_x && mouseX <= (ptch_fwd.rec_x+rectSize) && mouseY >= ptch_fwd.rec_y && mouseY <= (ptch_fwd.rec_y+rectSize) && mousePressed == true))
      movement(rot1,rot2);
    if(key == ptch_bkd.getDir() || (mouseX >= ptch_bkd.rec_x && mouseX <= (ptch_bkd.rec_x+rectSize) && mouseY >= ptch_bkd.rec_y && mouseY <= (ptch_bkd.rec_y+rectSize) && mousePressed == true))
      movement(rot3,rot4);
    if(key == role_r.getDir() || (mouseX >= role_r.rec_x && mouseX <= (role_r.rec_x+rectSize) && mouseY >= role_r.rec_y && mouseY <= (role_r.rec_y+rectSize) && mousePressed == true))
      movement(rot2,rot3);
    if(key == role_l.getDir() || (mouseX >= role_l.rec_x && mouseX <= (role_l.rec_x+rectSize) && mouseY >= role_l.rec_y && mouseY <= (role_l.rec_y+rectSize) && mousePressed == true))
      movement(rot1,rot4);
    if(key == yaw_cw.getDir() || (mouseX >= yaw_cw.rec_x && mouseX <= (yaw_cw.rec_x+rectSize) && mouseY >= yaw_cw.rec_y && mouseY <= (yaw_cw.rec_y+rectSize) && mousePressed == true))
      movement(rot1,rot3);
    if(key == yaw_ccw.getDir() || (mouseX >= yaw_ccw.rec_x && mouseX <= (yaw_ccw.rec_x+rectSize) && mouseY >= yaw_ccw.rec_y && mouseY <= (yaw_ccw.rec_y+rectSize) && mousePressed == true))
      movement(rot2,rot4);
  }
  else
  {
    rot1.stThrust(0);
    rot2.stThrust(0);
    rot3.stThrust(0);
    rot4.stThrust(0);
  }
  
  prev_val = rot.getThrust();
  rot1.rotShape();
  rot2.rotShape();
  rot3.rotShape();
  rot4.rotShape();
  rot.rotShape();
  
  
  bt1.batShape();
  bt2.batShape();
}
void movement(Thrust t1, Thrust t2)
{
  t1.stThrust(-power);
  t2.stThrust(-power);
}
class RectDraw
{
  int val,thrstVal;
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
  char getDir()
  {
    return dir;
  }
  
  void drawRect()
  {
    fill(0);
    if ((mouseX >= rec_x && mouseX <= (rec_x+rectSize) && mouseY >= rec_y && mouseY <= (rec_y+rectSize) && mousePressed == true) || ( keyPressed == true && key == dir))
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
  int val,thrst,thrst_dir;
  boolean clickp = false;
  boolean clickm = false;
  int inr_size =22;

  Thrust(int pos_x, int pos_y,String rot,int val)
  {
    this.pos_x = pos_x;
    this.pos_y = pos_y;
    this.rot = rot;
    this.val = val;
  }
  void setThrust(int val)
  {
    if((this.val += (val/10))>=2000)
      this.val = 1992;
    if((this.val += (val/10))<=1000)
      this.val = 1000;  
    else
      this.val += (val/10);
  }
  void stThrust(int thrst_dir)  {    this.thrst_dir = thrst_dir;  }
  int getThrust()  {  return this.val;  }
  void rotShape()
  {
    fill(0);
    rect(pos_x, pos_y, rectSize, rectCol,3);
    circle(pos_x+(rectSize/2),pos_y+rectCol+(rectSize/2)+10,rectSize);
    rect(pos_x+rectSize+10,pos_y+rectCol+(rectSize/2)-10,inr_size,inr_size);    // +
    rect(pos_x+rectSize+10,pos_y+rectCol+rectSize-25,inr_size,inr_size);    //  -
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
    textAlign(CENTER,CENTER);
    text(rot,pos_x+(rectSize/2),pos_y-10);
       
    text(val,pos_x+(rectSize/2),pos_y+rectCol+rectSize-30);
    if(mouseX >= pos_x+rectSize+10 && mouseX <= pos_x+rectSize+inr_size+10 &&mouseY >= pos_y+rectCol+(rectSize/2)-10 && mouseY <= pos_y+rectCol+(rectSize/2)-10+inr_size)
    {
      if(mousePressed == true)
      {
        fill(150);
        clickp = true;
      }
      else
      {
        fill(255);
        clickp = false;
      }
   }
   text("+",pos_x+100,pos_y+rectCol+rectSize-40);
   fill(255);
   if(mouseX >= pos_x+rectSize+10 && mouseX <= pos_x+rectSize+inr_size+10 && mouseY >= pos_y+rectCol+rectSize-25 && mouseY <= pos_y+rectCol+rectSize-25+inr_size)
    {
      if(mousePressed == true)
      {
        fill(150);
        clickm = true;
      }
      else
      {
        fill(255);
        clickm = false;
      }
    }
    text("-",pos_x+100,pos_y+rectCol+rectSize-15);
    
    int radX = abs(mouseX - pos_x- (rectSize/2));
    int radY = abs(mouseY - pos_y-rectCol-(rectSize/2));
    if((radX <= rectSize/2 && radY <= rectSize/2 && mouseX >= pos_x && mouseX <= pos_x+rectSize &&mouseY >= pos_y+rectCol+10 && mouseY <= pos_y+rectCol+10+rectSize) || (mouseX >= pos_x && mouseX <= pos_x+rectSize &&mouseY >= pos_y && mouseY <= pos_y+rectCol) || (clickp)|| (clickm))
     {
      if (clickp)
      {
         mw = -1.0;
      }
      if (clickm)
      {
         mw = +1.0;
      }
      if((val>=2000 && mw == -1.0) || (val>=2000 && clickp))
      {
        val = 2000;
      }
      else if((val<=1000 && mw == 1.0) || (val<=1000 && clickm))
      {
        val = 1000;
      }
      else
        thrst = int(mw*-10); // reverse wheel action
      mw = 0;
      val += thrst;
      //thrst_dir = val - thrst;
      thrst = val - prev_val - thrst_dir;
      
     }
     else
     {
       if(val>=1000 && val <= 2000)
         val = prev_val+thrst+thrst_dir;
       if(val>=2000)// || prev_val>2000)
       {
         val = 2000;
       }
       else if(val<=1000)// || prev_val<1000)
       {
         val = 1000;
       }       
     }
     text(val+":"+prev_val+":"+thrst+":"+thrst_dir,pos_x+20,pos_y+10);
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
    textAlign(RIGHT,CENTER);
    text(name,pos_x-30,pos_y-10);
    text("V ="+volt+"v",pos_x-30,pos_y+7);
    textAlign(CENTER,CENTER);
    text("Bat = "+nf(per,0,2)+"%",pos_x+50,pos_y-10);
    
  }
  void batDraw(int i)
  {
    pos_x = 23*width/25;
    pos_y = (height/40)+i;
  }
}
void mouseWheel(MouseEvent event) 
{
  mw = event.getCount();
}

  //}
      /* else
       {
         if(val >= 1000 && val<= 2000 && prev_val >= 1000 &&prev_val<= 2000)
         {
           //if(prev_val!=1000 && prev_val != 2000)
             val = prev_val+thrst;
           //else
             //val = prev_val; 
         }
         if(prev_val >= 2000 && val >= 2000)
         {
          thrst = 0;
           val = 2000;
         }
         if(prev_val >= 2000 && val >= 2000)
         {
           
         }
         if(prev_val <= 1000 && val <= 1000)
         {
           thrst = val-prev_val;
           val = 1000;
         }
       }*/
