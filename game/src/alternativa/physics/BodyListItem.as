package alternativa.physics {
  public class BodyListItem {
    private static var poolTop:BodyListItem;

    public var body:Body;
    public var next:BodyListItem;
    public var prev:BodyListItem;

    public function BodyListItem(param1:Body) {
      super();
      this.body = param1;
    }

    public static function create(param1:Body) : BodyListItem {
      var local2:BodyListItem = null;
      if(poolTop == null) {
        local2 = new BodyListItem(param1);
      } else {
        local2 = poolTop;
        poolTop = local2.next;
        local2.next = null;
        local2.body = param1;
      }
      return local2;
    }

    public static function clearPool() : void {
      var local1:BodyListItem = poolTop;
      while(local1 != null) {
        poolTop = local1.next;
        local1.next = null;
        local1 = poolTop;
      }
    }

    public function dispose() : void {
      this.body = null;
      this.prev = null;
      this.next = poolTop;
      poolTop = this;
    }
  }
}
