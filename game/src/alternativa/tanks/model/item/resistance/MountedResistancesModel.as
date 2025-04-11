package alternativa.tanks.model.item.resistance {
  import alternativa.tanks.service.resistance.ResistanceService;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.resistance.IMountedResistancesModelBase;
  import projects.tanks.client.garage.models.item.resistance.MountedResistancesModelBase;

  [ModelInfo]
  public class MountedResistancesModel extends MountedResistancesModelBase implements IMountedResistancesModelBase, ObjectLoadPostListener, ObjectUnloadListener, MountedResistances {
    [Inject]
    public static var resistanceService:ResistanceService;

    private var mountedResistances:Vector.<IGameObject>;

    public function MountedResistancesModel() {
      super();
    }

    public function getMounted() : Vector.<IGameObject> {
      return this.mountedResistances;
    }

    public function objectUnloaded() : void {
      resistanceService.unregisterModel();
    }

    public function objectLoadedPost() : void {
      this.mountedResistances = new Vector.<IGameObject>().concat(getInitParam().resistances);
      resistanceService.registerModel(object);
    }

    public function mount(param1:int, param2:IGameObject) : void {
      server.mount(param1,param2);
      var local3:* = this.mountedResistances.indexOf(param2);
      if(local3 > -1) {
        this.mountedResistances.splice(local3,1);
      }
      this.mountedResistances.push(param2);
    }

    public function unmount(param1:IGameObject) : void {
      this.mountedResistances.splice(this.mountedResistances.indexOf(param1),1);
      server.unmount(param1);
    }
  }
}
