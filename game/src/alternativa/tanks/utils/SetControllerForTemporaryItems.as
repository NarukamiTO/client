package alternativa.tanks.utils {
  import flash.utils.Dictionary;

  public class SetControllerForTemporaryItems {
    private var temporaryItems:Vector.<Object> = new Vector.<Object>();
    private var sourceSet:Dictionary;

    public function SetControllerForTemporaryItems(param1:Dictionary) {
      super();
      this.sourceSet = param1;
    }

    public function addTemporaryItem(param1:Object) : void {
      this.sourceSet[param1] = true;
      this.temporaryItems.push(param1);
    }

    public function deleteAllTemporaryItems() : void {
      var local1:int = 0;
      while(local1 < this.temporaryItems.length) {
        delete this.sourceSet[this.temporaryItems[local1]];
        local1++;
      }
      this.temporaryItems.length = 0;
    }
  }
}
