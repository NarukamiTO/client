package alternativa.tanks.battle.utils {
  public class QueueItem {
    private static var poolTop:QueueItem;

    public var next:QueueItem;
    public var data:*;

    public function QueueItem(param1:*) {
      super();
      this.data = param1;
    }

    public static function create(param1:*) : QueueItem {
      if(poolTop == null) {
        return new QueueItem(param1);
      }
      var local2:QueueItem = poolTop;
      poolTop = poolTop.next;
      local2.data = param1;
      return local2;
    }

    public function destroy() : void {
      this.data = null;
      this.next = poolTop;
      poolTop = this;
    }
  }
}
