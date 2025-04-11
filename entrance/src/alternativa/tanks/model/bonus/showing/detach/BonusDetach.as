package alternativa.tanks.model.bonus.showing.detach {
  import flash.events.Event;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.flash.commons.models.detach.Detach;

  public class BonusDetach {
    private var object:IGameObject;

    public function BonusDetach(param1:IGameObject) {
      super();
      this.object = param1;
    }

    public function detach(param1:Event = null) : void {
      Detach(this.object.adapt(Detach)).detach();
    }
  }
}
