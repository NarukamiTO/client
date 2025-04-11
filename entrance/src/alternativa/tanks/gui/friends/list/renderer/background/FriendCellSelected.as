package alternativa.tanks.gui.friends.list.renderer.background {
  import controls.cellrenderer.ButtonState;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Graphics;

  public class FriendCellSelected extends ButtonState {
    private static var leftIconClass:Class = FriendCellSelected_leftIconClass;
    private static var leftIconBitmapData:BitmapData = Bitmap(new leftIconClass()).bitmapData;
    private static var centerIconClass:Class = FriendCellSelected_centerIconClass;
    private static var centerIconBitmapData:BitmapData = Bitmap(new centerIconClass()).bitmapData;
    private static var rightIconClass:Class = FriendCellSelected_rightIconClass;
    private static var rightIconBitmapData:BitmapData = Bitmap(new rightIconClass()).bitmapData;

    public function FriendCellSelected() {
      super();
      bmpLeft = leftIconBitmapData;
      bmpCenter = centerIconBitmapData;
      bmpRight = rightIconBitmapData;
    }

    override public function draw() : void {
      var local1:Graphics = null;
      local1 = l.graphics;
      local1.clear();
      local1.beginBitmapFill(bmpLeft);
      local1.drawRect(0,0,5,20);
      local1.endFill();
      l.x = 0;
      l.y = 0;
      local1 = c.graphics;
      local1.clear();
      local1.beginBitmapFill(bmpCenter);
      local1.drawRect(0,0,_width - 10,20);
      local1.endFill();
      c.x = 5;
      c.y = 0;
      local1 = r.graphics;
      local1.clear();
      local1.beginBitmapFill(bmpRight);
      local1.drawRect(0,0,5,20);
      local1.endFill();
      r.x = _width - 5;
      r.y = 0;
    }
  }
}
