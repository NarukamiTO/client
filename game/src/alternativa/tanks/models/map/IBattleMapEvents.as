package alternativa.tanks.models.map {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.map.DustParams;
  import projects.tanks.client.battlefield.models.map.DynamicShadowParams;
  import projects.tanks.client.battlefield.models.map.FogParams;
  import projects.tanks.client.battlefield.models.map.SkyboxSides;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.clients.flash.resources.resource.MapResource;

  public class IBattleMapEvents implements IBattleMap {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IBattleMapEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMapResource() : MapResource {
      var result:MapResource = null;
      var i:int = 0;
      var m:IBattleMap = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleMap(this.impl[i]);
          result = m.getMapResource();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getEnvironmentSound() : SoundResource {
      var result:SoundResource = null;
      var i:int = 0;
      var m:IBattleMap = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleMap(this.impl[i]);
          result = m.getEnvironmentSound();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSkybox() : SkyboxSides {
      var result:SkyboxSides = null;
      var i:int = 0;
      var m:IBattleMap = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleMap(this.impl[i]);
          result = m.getSkybox();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getGravity() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:IBattleMap = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleMap(this.impl[i]);
          result = Number(m.getGravity());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSkyboxRevolutionAxis() : Vector3d {
      var result:Vector3d = null;
      var i:int = 0;
      var m:IBattleMap = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleMap(this.impl[i]);
          result = m.getSkyboxRevolutionAxis();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSkyBoxRevolutionSpeed() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:IBattleMap = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleMap(this.impl[i]);
          result = Number(m.getSkyBoxRevolutionSpeed());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getFogParams() : FogParams {
      var result:FogParams = null;
      var i:int = 0;
      var m:IBattleMap = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleMap(this.impl[i]);
          result = m.getFogParams();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDynamicShadowParams() : DynamicShadowParams {
      var result:DynamicShadowParams = null;
      var i:int = 0;
      var m:IBattleMap = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleMap(this.impl[i]);
          result = m.getDynamicShadowParams();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDustParams() : DustParams {
      var result:DustParams = null;
      var i:int = 0;
      var m:IBattleMap = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleMap(this.impl[i]);
          result = m.getDustParams();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSSAOColor() : uint {
      var result:uint = 0;
      var i:int = 0;
      var m:IBattleMap = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleMap(this.impl[i]);
          result = uint(m.getSSAOColor());
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
