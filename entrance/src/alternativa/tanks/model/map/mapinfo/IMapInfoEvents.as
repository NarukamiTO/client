package alternativa.tanks.model.map.mapinfo {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.model.map.params.MapTheme;

  public class IMapInfoEvents implements IMapInfo {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IMapInfoEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getName() : String {
      var result:String = null;
      var i:int = 0;
      var m:IMapInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapInfo(this.impl[i]);
          result = m.getName();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMapId() : Long {
      var result:Long = null;
      var i:int = 0;
      var m:IMapInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapInfo(this.impl[i]);
          result = m.getMapId();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMaxPeople() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IMapInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapInfo(this.impl[i]);
          result = int(m.getMaxPeople());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMaxRank() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IMapInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapInfo(this.impl[i]);
          result = int(m.getMaxRank());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMinRank() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IMapInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapInfo(this.impl[i]);
          result = int(m.getMinRank());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getThemeName() : String {
      var result:String = null;
      var i:int = 0;
      var m:IMapInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapInfo(this.impl[i]);
          result = m.getThemeName();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTheme() : MapTheme {
      var result:MapTheme = null;
      var i:int = 0;
      var m:IMapInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapInfo(this.impl[i]);
          result = m.getTheme();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDefaultTheme() : MapTheme {
      var result:MapTheme = null;
      var i:int = 0;
      var m:IMapInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapInfo(this.impl[i]);
          result = m.getDefaultTheme();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSupportedBattleModes() : Vector.<BattleMode> {
      var result:Vector.<BattleMode> = null;
      var i:int = 0;
      var m:IMapInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapInfo(this.impl[i]);
          result = m.getSupportedBattleModes();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isEnabled() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IMapInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapInfo(this.impl[i]);
          result = Boolean(m.isEnabled());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasMatchmakingMark() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IMapInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapInfo(this.impl[i]);
          result = Boolean(m.hasMatchmakingMark());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPreviewResource() : ImageResource {
      var result:ImageResource = null;
      var i:int = 0;
      var m:IMapInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapInfo(this.impl[i]);
          result = m.getPreviewResource();
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
