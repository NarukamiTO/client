package alternativa.physics {
  public class BodyList {
    public var head:BodyListItem;
    public var tail:BodyListItem;
    public var size:int;

    public function BodyList() {
      super();
    }

    public function append(param1:Body) : void {
      var local2:BodyListItem = BodyListItem.create(param1);
      if(this.head == null) {
        this.head = this.tail = local2;
      } else {
        this.tail.next = local2;
        local2.prev = this.tail;
        this.tail = local2;
      }
      ++this.size;
    }

    public function remove(param1:Body) : Boolean {
      var local2:BodyListItem = this.findItem(param1);
      if(local2 == null) {
        return false;
      }
      if(local2 == this.head) {
        if(this.size == 1) {
          this.head = this.tail = null;
        } else {
          this.head = local2.next;
          this.head.prev = null;
        }
      } else if(local2 == this.tail) {
        this.tail = local2.prev;
        this.tail.next = null;
      } else {
        local2.prev.next = local2.next;
        local2.next.prev = local2.prev;
      }
      local2.dispose();
      --this.size;
      return true;
    }

    public function findItem(param1:Body) : BodyListItem {
      var local2:BodyListItem = this.head;
      while(local2 != null && local2.body != param1) {
        local2 = local2.next;
      }
      return local2;
    }
  }
}
