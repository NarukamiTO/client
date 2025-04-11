package alternativa.tanks.battle.utils {
  public class Queue {
    private var head:QueueItem;
    private var tail:QueueItem;
    private var size:int;

    public function Queue() {
      super();
    }

    public function put(param1:*) : void {
      ++this.size;
      var local2:QueueItem = QueueItem.create(param1);
      if(this.tail == null) {
        this.head = local2;
        this.tail = local2;
      } else {
        this.tail.next = local2;
        this.tail = local2;
      }
    }

    public function pop() : * {
      if(this.head == null) {
        return null;
      }
      --this.size;
      var local1:* = this.head.data;
      var local2:QueueItem = this.head;
      this.head = this.head.next;
      local2.destroy();
      return local1;
    }

    public function getSize() : int {
      return this.size;
    }
  }
}
