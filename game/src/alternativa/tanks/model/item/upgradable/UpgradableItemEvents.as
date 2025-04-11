package alternativa.tanks.model.item.upgradable {
  import controls.timer.CountDownTimer;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class UpgradableItemEvents implements UpgradableItem {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function UpgradableItemEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getUpgradableItem() : UpgradableItemParams {
      var result:UpgradableItemParams = null;
      var i:int = 0;
      var m:UpgradableItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UpgradableItem(this.impl[i]);
          result = m.getUpgradableItem();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getUpgradableProperties() : Vector.<UpgradableItemPropertyValue> {
      var result:Vector.<UpgradableItemPropertyValue> = null;
      var i:int = 0;
      var m:UpgradableItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UpgradableItem(this.impl[i]);
          result = m.getUpgradableProperties();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getVisibleUpgradableProperties() : Vector.<UpgradableItemPropertyValue> {
      var result:Vector.<UpgradableItemPropertyValue> = null;
      var i:int = 0;
      var m:UpgradableItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UpgradableItem(this.impl[i]);
          result = m.getVisibleUpgradableProperties();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isUpgrading() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:UpgradableItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UpgradableItem(this.impl[i]);
          result = Boolean(m.isUpgrading());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function speedUp() : void {
      var i:int = 0;
      var m:UpgradableItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UpgradableItem(this.impl[i]);
          m.speedUp();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getCountDownTimer() : CountDownTimer {
      var result:CountDownTimer = null;
      var i:int = 0;
      var m:UpgradableItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UpgradableItem(this.impl[i]);
          result = m.getCountDownTimer();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function traceUpgrades() : void {
      var i:int = 0;
      var m:UpgradableItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UpgradableItem(this.impl[i]);
          m.traceUpgrades();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function hasUpgradeDiscount() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:UpgradableItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UpgradableItem(this.impl[i]);
          result = Boolean(m.hasUpgradeDiscount());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasSpeedUpDiscount() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:UpgradableItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UpgradableItem(this.impl[i]);
          result = Boolean(m.hasSpeedUpDiscount());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
