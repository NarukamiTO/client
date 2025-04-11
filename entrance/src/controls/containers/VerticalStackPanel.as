package controls.containers {
  import flash.display.DisplayObject;

  public class VerticalStackPanel extends StackPanel {
    public function VerticalStackPanel() {
      super();
    }

    override protected function increaseContainerSize(param1:DisplayObject) : void {
      if(items.length < 2) {
        height = param1.y + int(param1.height);
        width = Math.max(width,param1.x + fixWidth(param1));
        return;
      }
      var local2:DisplayObject = items[items.length - 2];
      var local3:int = param1.y;
      param1.y = local2.y + int(local2.height) + getMargin() + param1.y;
      height = local2.y + int(local2.height) + getMargin() + local3 + int(param1.height);
      width = Math.max(int(width),param1.x + fixWidth(param1));
    }

    override protected function decreaseContainerSize(param1:int, param2:DisplayObject) : void {
      if(param1 <= 0) {
        width = 0;
        height = 0;
        return;
      }
      if(param1 == items.length) {
        width = this.calculateMaxWidth();
        height = items[items.length - 1].y + int(items[items.length - 1].height);
        return;
      }
      var local3:int = items[param1].y - param2.y;
      var local4:int = param1;
      while(local4 < items.length) {
        items[local4].y -= local3;
        local4++;
      }
      height = items[items.length - 1].y + int(items[items.length - 1].height);
      width = this.calculateMaxWidth();
    }

    private function calculateMaxWidth() : int {
      var local2:DisplayObject = null;
      var local1:int = 0;
      for each(local2 in items) {
        local1 = Math.max(local1,local2.x + fixWidth(local2));
      }
      return local1;
    }
  }
}
