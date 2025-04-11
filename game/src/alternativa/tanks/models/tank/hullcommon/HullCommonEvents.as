package alternativa.tanks.models.tank.hullcommon {
  import flash.display.BitmapData;
  import flash.media.Sound;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.armor.common.HullCommonCC;

  public class HullCommonEvents implements HullCommon {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function HullCommonEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCC() : HullCommonCC {
      var result:HullCommonCC = null;
      var i:int = 0;
      var m:HullCommon = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = HullCommon(this.impl[i]);
          result = m.getCC();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDeadColoring() : TextureResource {
      var result:TextureResource = null;
      var i:int = 0;
      var m:HullCommon = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = HullCommon(this.impl[i]);
          result = m.getDeadColoring();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMass() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:HullCommon = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = HullCommon(this.impl[i]);
          result = Number(m.getMass());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function setTankObject(param1:IGameObject) : void {
      var i:int = 0;
      var m:HullCommon = null;
      var tank:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = HullCommon(this.impl[i]);
          m.setTankObject(tank);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getTankObject() : IGameObject {
      var result:IGameObject = null;
      var i:int = 0;
      var m:HullCommon = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = HullCommon(this.impl[i]);
          result = m.getTankObject();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getStunEffectTexture() : BitmapData {
      var result:BitmapData = null;
      var i:int = 0;
      var m:HullCommon = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = HullCommon(this.impl[i]);
          result = m.getStunEffectTexture();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getStunSound() : Sound {
      var result:Sound = null;
      var i:int = 0;
      var m:HullCommon = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = HullCommon(this.impl[i]);
          result = m.getStunSound();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getUltimateIconIndex() : int {
      var result:int = 0;
      var i:int = 0;
      var m:HullCommon = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = HullCommon(this.impl[i]);
          result = int(m.getUltimateIconIndex());
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
