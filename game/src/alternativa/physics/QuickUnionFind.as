package alternativa.physics {
  public class QuickUnionFind {
    private var items:Vector.<int>;
    private var size:Vector.<int>;

    public function QuickUnionFind() {
      super();
      this.items = new Vector.<int>(1);
      this.size = new Vector.<int>(1);
    }

    public function init(param1:int) : void {
      this.items.length = param1;
      this.size.length = param1;
      var local2:int = 0;
      while(local2 < param1) {
        this.items[local2] = local2;
        this.size[local2] = 1;
        local2++;
      }
    }

    public function union(param1:int, param2:int) : void {
      var local3:int = 0;
      var local4:int = 0;
      var local5:int = 0;
      var local6:int = 0;
      if(!this.connected(param1,param2)) {
        local3 = this.root(param1);
        local4 = this.root(param2);
        local5 = this.size[local3];
        local6 = this.size[local4];
        if(local5 > local6) {
          this.items[local4] = local3;
          this.size[local3] += local6;
        } else {
          this.items[local3] = local4;
          this.size[local4] += local5;
        }
      }
    }

    public function connected(param1:int, param2:int) : Boolean {
      return this.root(param1) == this.root(param2);
    }

    public function root(param1:int) : int {
      var local2:int = param1;
      while(this.items[local2] != local2) {
        local2 = this.items[local2];
      }
      return local2;
    }
  }
}
