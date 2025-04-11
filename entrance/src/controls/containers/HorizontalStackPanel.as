package controls.containers {
  import flash.display.DisplayObject;

  public class HorizontalStackPanel extends StackPanel {
    public function HorizontalStackPanel() {
      super();
    }

    override protected function increaseContainerSize(param1:DisplayObject) : void {
      var local5:int = 0;
      if(items.length < 2) {
        height = param1.y + int(param1.height);
        width = param1.x + fixWidth(param1);
        return;
      }
      var local2:DisplayObject = items[items.length - 2];
      var local3:int = fixWidth(local2);
      var local4:int = fixWidth(param1);
      local5 = param1.x;
      param1.x = local2.x + local3 + getMargin() + local5;
      height = Math.max(int(height),param1.y + int(param1.height));
      width = local2.x + local3 + getMargin() + local5 + local4;
    }

    override protected function decreaseContainerSize(param1:int, param2:DisplayObject) : void {
      if(param1 <= 0) {
        width = 0;
        height = 0;
        return;
      }
      if(param1 == items.length) {
        height = this.calculateMaxHeight();
        width = items[items.length - 1].x - fixWidth(items[items.length - 1]);
        return;
      }
      var local3:int = items[param1].x - param2.x;
      var local4:int = param1;
      while(local4 < items.length) {
        items[local4].x -= local3;
        local4++;
      }
      width = items[items.length - 1].x + fixWidth(items[items.length - 1]);
      height = this.calculateMaxHeight();
    }

    private function calculateMaxHeight() : int {
      var local2:DisplayObject = null;
      var local1:int = 0;
      for each(local2 in items) {
        local1 = Math.max(local1,local2.y + local2.height);
      }
      return local1;
    }
  }
}
