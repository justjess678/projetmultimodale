/*
 *  vocal_ivy -> Demonstration with ivy middleware
 * v. 1.0
 * 
 * (c) Ph. Truillet, October 2018
 * Last Revision: 01/10/2018
 */
 
import fr.dgac.ivy.*;

// data

Ivy bus;
PFont f;
String message= "";

void setup()
{
  size(400,100);
  fill(0,255,0);
  f = loadFont("TwCenMT-Regular-24.vlw");
  textFont(f,18);
  try
  {
    bus = new Ivy("sra_tts_bridge", " sra_tts_bridge is ready", null);
    bus.start("127.255.255.255:2010");
    
    bus.bindMsg("^sra5 Parsed=action : (.*) (shape : (.*)){0,1} (color : (.*)){0,1} (postion : (.*)){0,1} Confidence=.*", new IvyMessageListener()
    {
      public void receive(IvyClient client,String[] args)
      {
        message = args[0];
        try {
          bus.sendMsg("ppilot5 Say=Vous avez dit : " + args[0]); 
        }
        catch (IvyException e) {         
        }
      }        
    });
    
  }
  catch (IvyException ie)
  {
  }
}

void draw()
{
  background(0);
  text("** MESSAGE RECU **", 20,20);
  text(message, 20, 50);
}
