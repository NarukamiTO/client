package alternativa.tanks.model.bonus.showing.info {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.LocalizedImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public class BonusInfoEvents implements BonusInfo {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BonusInfoEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getTopText() : String {
      var result:String = null;
      var i:int = 0;
      var m:BonusInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BonusInfo(this.impl[i]);
          result = m.getTopText();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getBottomText() : String {
      var result:String = null;
      var i:int = 0;
      var m:BonusInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BonusInfo(this.impl[i]);
          result = m.getBottomText();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getImage() : LocalizedImageResource {
      var result:LocalizedImageResource = null;
      var i:int = 0;
      var m:BonusInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BonusInfo(this.impl[i]);
          result = m.getImage();
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
