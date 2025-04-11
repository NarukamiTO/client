package alternativa.tanks.models.tank.hullcommon {
  import flash.display.BitmapData;
  import flash.media.Sound;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.armor.common.HullCommonCC;

  public class HullCommonAdapt implements HullCommon {
    private var object:IGameObject;
    private var impl:HullCommon;

    public function HullCommonAdapt(param1:IGameObject, param2:HullCommon) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCC() : HullCommonCC {
      var result:HullCommonCC = null;
      try {
        Model.object = this.object;
        result = this.impl.getCC();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDeadColoring() : TextureResource {
      var result:TextureResource = null;
      try {
        Model.object = this.object;
        result = this.impl.getDeadColoring();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMass() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = this.impl.getMass();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function setTankObject(param1:IGameObject) : void {
      var tank:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.setTankObject(tank);
      }
      finally {
        Model.popObject();
      }
    }

    public function getTankObject() : IGameObject {
      var result:IGameObject = null;
      try {
        Model.object = this.object;
        result = this.impl.getTankObject();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getStunEffectTexture() : BitmapData {
      var result:BitmapData = null;
      try {
        Model.object = this.object;
        result = this.impl.getStunEffectTexture();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getStunSound() : Sound {
      var result:Sound = null;
      try {
        Model.object = this.object;
        result = this.impl.getStunSound();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getUltimateIconIndex() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = this.impl.getUltimateIconIndex();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
