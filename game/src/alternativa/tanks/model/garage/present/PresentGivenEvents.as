package alternativa.tanks.model.garage.present {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PresentGivenEvents implements PresentGiven {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PresentGivenEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function removePresent(param1:Long) : void {
      var i:int = 0;
      var m:PresentGiven = null;
      var present:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PresentGiven(this.impl[i]);
          m.removePresent(present);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
