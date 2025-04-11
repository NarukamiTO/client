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

  public class IBattleMapAdapt implements IBattleMap {
    private var object:IGameObject;
    private var impl:IBattleMap;

    public function IBattleMapAdapt(param1:IGameObject, param2:IBattleMap) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMapResource() : MapResource {
      var result:MapResource = null;
      try {
        Model.object = this.object;
        result = this.impl.getMapResource();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getEnvironmentSound() : SoundResource {
      var result:SoundResource = null;
      try {
        Model.object = this.object;
        result = this.impl.getEnvironmentSound();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSkybox() : SkyboxSides {
      var result:SkyboxSides = null;
      try {
        Model.object = this.object;
        result = this.impl.getSkybox();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getGravity() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getGravity());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSkyboxRevolutionAxis() : Vector3d {
      var result:Vector3d = null;
      try {
        Model.object = this.object;
        result = this.impl.getSkyboxRevolutionAxis();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSkyBoxRevolutionSpeed() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getSkyBoxRevolutionSpeed());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getFogParams() : FogParams {
      var result:FogParams = null;
      try {
        Model.object = this.object;
        result = this.impl.getFogParams();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDynamicShadowParams() : DynamicShadowParams {
      var result:DynamicShadowParams = null;
      try {
        Model.object = this.object;
        result = this.impl.getDynamicShadowParams();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDustParams() : DustParams {
      var result:DustParams = null;
      try {
        Model.object = this.object;
        result = this.impl.getDustParams();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSSAOColor() : uint {
      var result:uint = 0;
      try {
        Model.object = this.object;
        result = uint(this.impl.getSSAOColor());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
