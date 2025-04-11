package alternativa.tanks.models.weapon.shared.shot {
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battlefield.models.tankparts.weapon.shot.DiscreteShotModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.shot.IDiscreteShotModelBase;

  [ModelInfo]
  public class DiscreteShotModel extends DiscreteShotModelBase implements IDiscreteShotModelBase, IShotModel, ObjectLoadListener {
    public function DiscreteShotModel() {
      super();
    }

    public function objectLoaded() : void {
      putData(EncryptedInt,new EncryptedIntImpl(getInitParam().reloadMsec));
    }

    public function getReloadMS() : int {
      return EncryptedInt(getData(EncryptedInt)).getInt();
    }

    public function reconfigureWeapon(param1:int) : void {
      var local2:EncryptedInt = EncryptedInt(getData(EncryptedInt));
      var local3:int = int(local2.getInt());
      local2.setInt(param1);
      WeaponReloadTimeChangedListener(object.event(WeaponReloadTimeChangedListener)).weaponReloadTimeChanged(local3,param1);
    }
  }
}
