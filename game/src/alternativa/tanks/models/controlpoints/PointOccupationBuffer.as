package alternativa.tanks.models.controlpoints {
  import alternativa.types.Long;
  import flash.utils.Dictionary;

  public class PointOccupationBuffer {
    private var buffer:Dictionary = new Dictionary();

    public function PointOccupationBuffer() {
      super();
    }

    public function add(param1:Long, param2:int) : void {
      this.buffer[param1] = param2;
    }

    public function remove(param1:Long) : void {
      delete this.buffer[param1];
    }

    public function takeTankPointId(param1:Long) : int {
      var local2:int = 0;
      if(this.buffer[param1] != undefined) {
        local2 = int(this.buffer[param1]);
        delete this.buffer[param1];
        return local2;
      }
      return -1;
    }
  }
}
