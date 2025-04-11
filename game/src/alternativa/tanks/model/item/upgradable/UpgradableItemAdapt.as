package alternativa.tanks.model.item.upgradable {
  import controls.timer.CountDownTimer;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class UpgradableItemAdapt implements UpgradableItem {
    private var object:IGameObject;
    private var impl:UpgradableItem;

    public function UpgradableItemAdapt(param1:IGameObject, param2:UpgradableItem) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getUpgradableItem() : UpgradableItemParams {
      var result:UpgradableItemParams = null;
      try {
        Model.object = this.object;
        result = this.impl.getUpgradableItem();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getUpgradableProperties() : Vector.<UpgradableItemPropertyValue> {
      var result:Vector.<UpgradableItemPropertyValue> = null;
      try {
        Model.object = this.object;
        result = this.impl.getUpgradableProperties();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getVisibleUpgradableProperties() : Vector.<UpgradableItemPropertyValue> {
      var result:Vector.<UpgradableItemPropertyValue> = null;
      try {
        Model.object = this.object;
        result = this.impl.getVisibleUpgradableProperties();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isUpgrading() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isUpgrading());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function speedUp() : void {
      try {
        Model.object = this.object;
        this.impl.speedUp();
      }
      finally {
        Model.popObject();
      }
    }

    public function getCountDownTimer() : CountDownTimer {
      var result:CountDownTimer = null;
      try {
        Model.object = this.object;
        result = this.impl.getCountDownTimer();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function traceUpgrades() : void {
      try {
        Model.object = this.object;
        this.impl.traceUpgrades();
      }
      finally {
        Model.popObject();
      }
    }

    public function hasUpgradeDiscount() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.hasUpgradeDiscount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasSpeedUpDiscount() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.hasSpeedUpDiscount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
