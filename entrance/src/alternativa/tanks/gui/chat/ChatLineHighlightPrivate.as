package alternativa.tanks.gui.chat {
  import controls.statassets.*;
  import flash.display.BitmapData;

  public class ChatLineHighlightPrivate extends StatLineBase {
    private static const cornerBitmapClass:Class = ChatLineHighlightPrivate_cornerBitmapClass;
    private static const cornerBitmapData:BitmapData = new cornerBitmapClass().bitmapData;

    public function ChatLineHighlightPrivate() {
      super();
      tl = cornerBitmapData;
      px = new BitmapData(1,1,false,3313951);
    }
  }
}
