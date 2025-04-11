package alternativa.tanks.view.battlelist.friends {
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;

  public class FriendsIndicator extends Sprite {
    private static var friendsGreenClass:Class = FriendsIndicator_friendsGreenClass;
    private static var friendsGreenBitmapData:BitmapData = Bitmap(new friendsGreenClass()).bitmapData;
    private static var friendsGreyClass:Class = FriendsIndicator_friendsGreyClass;
    private static var friendsGreyBitmapData:BitmapData = Bitmap(new friendsGreyClass()).bitmapData;

    private var label:LabelBase = new LabelBase();
    private var friendsIcon:Bitmap;

    public function FriendsIndicator(param1:Boolean, param2:int, param3:uint) {
      super();
      this.init(param1,param2,param3);
    }

    public function setFriendCount(param1:int) : void {
      this.label.text = String(param1);
    }

    public function setAccessable(param1:Boolean) : void {
      removeChild(this.friendsIcon);
      this.friendsIcon = new Bitmap(param1 ? friendsGreenBitmapData : friendsGreyBitmapData);
      addChild(this.friendsIcon);
    }

    private function init(param1:Boolean, param2:int, param3:uint) : void {
      graphics.clear();
      graphics.beginFill(16711680,0);
      graphics.drawRect(0,0,18,16);
      graphics.endFill();
      this.friendsIcon = new Bitmap(param1 ? friendsGreenBitmapData : friendsGreyBitmapData);
      this.friendsIcon.y = 3;
      addChild(this.friendsIcon);
      this.label.text = String(param2);
      this.label.x = this.friendsIcon.width;
      this.label.y = -1;
      this.label.color = param3;
      addChild(this.label);
    }
  }
}
