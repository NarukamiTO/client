package alternativa.tanks.gui.chat {
  import assets.stat.hall_NORMAL;
  import controls.statassets.StatLineBase;
  import flash.display.BitmapData;

  public class ChatLineHighlightNormal extends StatLineBase {
    public function ChatLineHighlightNormal() {
      super();
      tl = new hall_NORMAL(1,1);
      px = new BitmapData(1,1,false,543488);
    }
  }
}
