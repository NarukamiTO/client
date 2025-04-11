package alternativa.tanks.model.map.mapinfo {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.model.map.params.MapTheme;

  public class IMapInfoAdapt implements IMapInfo {
    private var object:IGameObject;
    private var impl:IMapInfo;

    public function IMapInfoAdapt(param1:IGameObject, param2:IMapInfo) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getName() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getName();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMapId() : Long {
      var result:Long = null;
      try {
        Model.object = this.object;
        result = this.impl.getMapId();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMaxPeople() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getMaxPeople());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMaxRank() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getMaxRank());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMinRank() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getMinRank());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getThemeName() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getThemeName();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTheme() : MapTheme {
      var result:MapTheme = null;
      try {
        Model.object = this.object;
        result = this.impl.getTheme();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDefaultTheme() : MapTheme {
      var result:MapTheme = null;
      try {
        Model.object = this.object;
        result = this.impl.getDefaultTheme();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSupportedBattleModes() : Vector.<BattleMode> {
      var result:Vector.<BattleMode> = null;
      try {
        Model.object = this.object;
        result = this.impl.getSupportedBattleModes();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isEnabled() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isEnabled());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasMatchmakingMark() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.hasMatchmakingMark());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPreviewResource() : ImageResource {
      var result:ImageResource = null;
      try {
        Model.object = this.object;
        result = this.impl.getPreviewResource();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
