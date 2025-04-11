package alternativa.tanks.model.garage.present {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PresentGivenAdapt implements PresentGiven {
    private var object:IGameObject;
    private var impl:PresentGiven;

    public function PresentGivenAdapt(param1:IGameObject, param2:PresentGiven) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function removePresent(param1:Long) : void {
      var present:Long = param1;
      try {
        Model.object = this.object;
        this.impl.removePresent(present);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
