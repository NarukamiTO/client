package alternativa.tanks.utils {
  public class KeyboardKeyLocker {
    private var lockedKeys:Vector.<uint> = new Vector.<uint>();

    public function KeyboardKeyLocker() {
      super();
    }

    public function isKeyLocked(param1:uint) : Boolean {
      return this.lockedKeys.indexOf(param1) != -1;
    }

    public function lockKey(param1:uint) : void {
      if(this.lockedKeys.indexOf(param1) == -1) {
        this.lockedKeys.push(param1);
      }
    }

    public function unlockKey(param1:uint) : void {
      var local2:Number = Number(this.lockedKeys.indexOf(param1));
      if(local2 >= 0) {
        this.lockedKeys.splice(local2,1);
      }
    }
  }
}
