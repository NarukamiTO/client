package projects.tanks.client.battlefield.models.effects.activationsfx {
  import platform.client.fp10.core.resource.types.TextureResource;

  public class EffectSFXRecordCC {
    private var _beam:TextureResource;
    private var _effectTag:int;
    private var _star:TextureResource;

    public function EffectSFXRecordCC(param1:TextureResource = null, param2:int = 0, param3:TextureResource = null) {
      super();
      this._beam = param1;
      this._effectTag = param2;
      this._star = param3;
    }

    public function get beam() : TextureResource {
      return this._beam;
    }

    public function set beam(param1:TextureResource) : void {
      this._beam = param1;
    }

    public function get effectTag() : int {
      return this._effectTag;
    }

    public function set effectTag(param1:int) : void {
      this._effectTag = param1;
    }

    public function get star() : TextureResource {
      return this._star;
    }

    public function set star(param1:TextureResource) : void {
      this._star = param1;
    }

    public function toString() : String {
      var local1:String = "EffectSFXRecordCC [";
      local1 += "beam = " + this.beam + " ";
      local1 += "effectTag = " + this.effectTag + " ";
      local1 += "star = " + this.star + " ";
      return local1 + "]";
    }
  }
}
