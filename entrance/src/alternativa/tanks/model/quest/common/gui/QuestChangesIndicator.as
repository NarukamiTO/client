package alternativa.tanks.model.quest.common.gui {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;

  public class QuestChangesIndicator extends Sprite {
    private static var questsChangesIconClass:Class = QuestChangesIndicator_questsChangesIconClass;
    private static var questsChangesIconBitmapData:BitmapData = Bitmap(new questsChangesIconClass()).bitmapData;

    public function QuestChangesIndicator() {
      super();
      var local1:Bitmap = new Bitmap(questsChangesIconBitmapData);
      addChild(local1);
      visible = false;
    }
  }
}
