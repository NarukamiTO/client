package alternativa.tanks.models.tank.resistance {
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.LocalWeaponController;
  import alternativa.tanks.models.tank.bosstate.IBossState;
  import alternativa.tanks.services.tankregistry.TankUsersRegistry;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
  import projects.tanks.client.battlefield.models.user.resistance.ITankResistancesModelBase;
  import projects.tanks.client.battlefield.models.user.resistance.TankResistance;
  import projects.tanks.client.battlefield.models.user.resistance.TankResistancesModelBase;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  [ModelInfo]
  public class TankResistancesModel extends TankResistancesModelBase implements ITankResistancesModelBase, TankResistances, ObjectLoadPostListener {
    [Inject]
    public static var usersRegistry:TankUsersRegistry;

    public function TankResistancesModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      var local1:IGameObject = null;
      if(Boolean(usersRegistry.existLocalUser()) && usersRegistry.getLocalUser() == object) {
        for each(local1 in usersRegistry.getUsers()) {
          if(local1 != object) {
            this.setResistance(local1,true);
          }
        }
      } else {
        this.setResistance(object,true);
      }
    }

    public function getResistance(param1:Boolean) : int {
      if(!usersRegistry.existLocalUser() || usersRegistry.getLocalUser() == object) {
        return 0;
      }
      var local2:IGameObject = usersRegistry.getLocalUser();
      if(this.isBoss(local2)) {
        return 0;
      }
      var local3:ITankModel = ITankModel(local2.adapt(ITankModel));
      var local4:Dictionary = Dictionary(getData(Dictionary));
      if(local4 == null || param1) {
        local4 = this.createResistanceDictionary();
        putData(Dictionary,local4);
      }
      if(ItemProperty.ALL_RESISTANCE in local4) {
        return local4[ItemProperty.ALL_RESISTANCE];
      }
      var local5:LocalWeaponController = LocalWeaponController(local3.getWeaponController());
      var local6:ItemProperty = local5.getResistanceProperty();
      if(local6 in local4) {
        return local4[local6];
      }
      return 0;
    }

    private function isBoss(param1:IGameObject) : Boolean {
      return IBossState(param1.adapt(IBossState)).role() == BossRelationRole.BOSS;
    }

    public function getResistances() : Vector.<TankResistance> {
      return getInitParam().resistances;
    }

    private function createResistanceDictionary() : Dictionary {
      var local2:TankResistance = null;
      var local1:Dictionary = new Dictionary();
      for each(local2 in getInitParam().resistances) {
        local1[local2.resistanceProperty] = local2.resistanceInPercent;
      }
      return local1;
    }

    private function setResistance(param1:IGameObject, param2:Boolean) : void {
      var local3:int = int(TankResistances(param1.adapt(TankResistances)).getResistance(param2));
      ITankModel(param1.adapt(ITankModel)).getTitle().setResistance(local3);
    }

    public function updateOthersResistances() : void {
      var local1:IGameObject = null;
      for each(local1 in usersRegistry.getUsers()) {
        if(local1 != object) {
          this.setResistance(local1,true);
        }
      }
    }
  }
}
